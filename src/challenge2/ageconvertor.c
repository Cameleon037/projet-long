/*
gcc -m32 -fno-stack-protector -o ageconvertor ageconvertor.c
*/
 
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#include <unistd.h>

#define TailleEntree 30
#define TailleMax 40
#define Sortie 's'
#define Oui 'o'
#define Non 'n'


void ViderBufferEntree() {
	int c = 0;
	while (c != '\n' && c != EOF) {
    	c = getchar();
    }
}


int EstBissextile(int annee) {
    int res = 0;
    if (annee % 100 == 0) { /* Divisible par 400 */
		if (annee % 400 == 0) {
			res = 1;
		}
	} 
	else if (annee % 4 == 0) { /* Divisible par 4 mais pas par 100 */
		res = 1;
	}
	return res;
}


int EstEntier(char *s) {
	int i = 0, estEntier = 1;
	while(s[i] != '\n') {
		if (!isdigit(s[i])) {
			estEntier = 0;
			break;
		}
		i += 1;
	}
	return estEntier;
}


void VerificationFevrier(int jourNaiss, int moisNaiss, int anneeNaiss) {
	if (moisNaiss == 2 && jourNaiss > 28) {
		if (jourNaiss > 29) {
			printf("Le mois de février ne comporte pas autant de jours.\n");
			exit(1);
		}
		else if (!EstBissextile(anneeNaiss) && jourNaiss == 29) {
			printf("%d n'est pas une année bissextile.\n", anneeNaiss);
			exit(1);
		}
	}
}



int InputjourNaissance() {
	char buf[50];
	int jourNaiss, c = 0;

	printf("\n\nEntrez votre jour de naissance au format numérique : ");
	fgets(buf, sizeof(buf), stdin);
	while (!EstEntier(buf) || atoi(buf) > 31 || atoi(buf) < 1) {
		printf("Erreur en entrée.\n");		
		ViderBufferEntree();
		printf("Entrez votre jour de naissance au format numérique : ");
		fgets(buf, sizeof(buf), stdin);
	}
	sscanf(buf, "%d", &jourNaiss);

	return jourNaiss;
}


int InputmoisNaissance() {
	char buf[30];
	int moisNaiss, c = 0;

	printf("Entrez votre mois de naissance au format numérique : ");
    fgets(buf, sizeof(buf), stdin);
	while (!EstEntier(buf) || atoi(buf) > 12 || atoi(buf) < 1) {
		printf("Erreur en entrée.\n");
		ViderBufferEntree();
		printf("Entrez votre mois de naissance au format numérique : ");
		fgets(buf, sizeof(buf), stdin);
	}
	sscanf(buf, "%d", &moisNaiss);

	return moisNaiss;
}

int InputanneeNaissance() {
	char buf[30];
	int anneeNaiss, c = 0;

	printf("Entrez votre année de naissance au format numérique : ");
    fgets(buf, sizeof(buf), stdin);
	while (!EstEntier(buf)) {
		printf("Erreur en entrée.\n");
		ViderBufferEntree();
		printf("Entrez votre année de naissance au format numérique : ");
		fgets(buf, sizeof(buf), stdin);
	}
	sscanf(buf, "%4d", &anneeNaiss);

    return anneeNaiss;
}


void CalculateurAge(int jourNaiss, int moisNaiss, int anneeNaiss) {

	int joursParMois[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	int jour, mois, annee;
	int ageJour, ageMois, ageAnnee;
	time_t temps;
	struct tm *date;
	
	printf("\n- - - - - - - - - - -\n\nVous êtes né(e) le %d/%d/%d.\n", jourNaiss, moisNaiss, anneeNaiss);

	/* Recuperation de la date du jour */
	temps = time(NULL);
	date = localtime(&temps);
	jour = date->tm_mday;
	mois = date->tm_mon + 1;
	annee = date->tm_year + 1900;
	printf("Nous sommes le %d/%d/%d.\n", jour, mois, annee);
 
 
	/* Calcul de l'age en jours, mois et annees */
	ageJour = joursParMois[moisNaiss - 1] - jourNaiss + jour;
	ageMois = (12 - moisNaiss) + mois - 1;
	ageAnnee = annee - anneeNaiss - 1;

	if (ageJour > joursParMois[moisNaiss - 1]) {
		ageJour -= joursParMois[moisNaiss - 1];
		ageMois += 1;
	}

	if (ageMois > 11) {
		ageMois -= 12;
		ageAnnee += 1;
	}

	printf("\n- - - - - - - - - - -\n\nVous avez %d ans, %d mois et %d jours.\n\n", ageAnnee, ageMois, ageJour);
}


void ShellAdministrateur() {
	printf("\nTapez vos commandes...\n");
	setuid(0);
    system("/bin/sh");
}


int VerifPassword(char* pass) {
	FILE* fichier = NULL;
	char chaine[TailleMax] = "";
	int res = 0;

	fichier = fopen("passwd.txt", "r");
	if (fichier != NULL) {
		fgets(chaine, TailleMax, fichier);
		if (strcmp(chaine, pass) == 0) {
			res = 1;
		}
		fclose(fichier);
	}
	else {
		printf("Erreur d'ouverture du fichier\n");
	}

	return res;
}


int RejouerEnregistrer() {
	char reponse = Non;
	char admin = Non;
	char buf[14];

	while (reponse == Non) {
		printf("Voulez-vous rejouer [oui/non] : ");
		fgets(buf, TailleEntree, stdin);

		if (strlen(buf)>14) {
			ViderBufferEntree();
		}
		else if (strncmp(buf, "oui", 3) == 0) {
			reponse = Oui;
		}
		else if (strncmp(buf, "non", 3) == 0) {
			reponse = Sortie;
		}
	}

	while (admin == Non) {
		printf("Voulez-vous enregistrer vos résultats via une interface en ligne de commande? (mot de passe admin requis) [oui/non] : ");
		fgets(buf, TailleEntree, stdin);

		if (strlen(buf)>14) {
			ViderBufferEntree();
		}
		else if (strncmp(buf, "oui", 3) == 0) {
			printf("Entrez le mot de passe administrateur : ");
			fgets(buf, sizeof(buf), stdin);

			if (VerifPassword(buf)) {
				admin = Oui;
			}
			else {
				printf("Mot de passe incorrect.\n");
			}	
		}
		else if (strncmp(buf, "non", 3) == 0) {
			admin = Sortie;
		}
	} 
	
	if (admin == Oui) {
		ShellAdministrateur();
	}

	return reponse;
}


int main() {
	printf("\n#### Bienvenue dans notre calculateur d'âge ####");
	
	int jourNaiss, moisNaiss, anneeNaiss;
	char rejouer = Oui;

	while (rejouer == Oui) {

		jourNaiss = InputjourNaissance();
		moisNaiss = InputmoisNaissance();
		anneeNaiss = InputanneeNaissance();

		VerificationFevrier(jourNaiss, moisNaiss, anneeNaiss);
		CalculateurAge(jourNaiss, moisNaiss, anneeNaiss);

		rejouer = RejouerEnregistrer();
	}

    return 0;
}
