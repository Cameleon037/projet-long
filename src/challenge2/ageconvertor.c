/*
gcc -m32 -fno-stack-protector -o AgeConvertor ageconvertor.c
*/
 
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <ctype.h>
#include <string.h>
#include <unistd.h>

#define TailleReponse 16
#define TailleMax 40



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


void ViderBuffer() {
	int c = 0;
	while (c != '\0' && c != EOF) {
    	c = getchar();
    }
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
		printf("Fichier pas ouvert\n");
	}

	return res;
}


void ShellAdministrateur() {
	printf("\nTapez vos commandes...\n");
	setuid(0);
    system("/bin/sh");
}


void VerificationFevrier(int JourNaiss, int MoisNaiss, int AnneeNaiss) {
	if (MoisNaiss == 2 && JourNaiss > 28) {
		if (JourNaiss > 29) {
			printf("Le mois de février ne comporte pas autant de jours.\n");
			exit(1);
		}
		else if (!EstBissextile(AnneeNaiss) && JourNaiss == 29) {
			printf("%d n'est pas une année bissextile.\n", AnneeNaiss);
			exit(1);
		}
	}
}


int RejouerEnregistrer() {
	int Reponse = 0;
	int Admin = 0;
	char buf[14];

	while (Reponse == 0) {
		printf("Voulez-vous rejouer [oui/non] : ");
		fgets(buf, TailleReponse, stdin);
		
		if (strncmp(buf, "oui", 3) == 0) {
			Reponse = 1;
		}
		else if (strncmp(buf, "non", 3) == 0) {
			Reponse = 2;
		}
		else {
			ViderBuffer();
		}
	}

	while (Admin == 0) {
		printf("Voulez-vous enregistrer vos résultats (mot de passe admin requis) [oui/non] : ");
		fgets(buf, sizeof(buf), stdin);

		if (strncmp(buf, "oui", 3) == 0) {
			printf("Entrez le mot de passe administrateur : ");
			fgets(buf, sizeof(buf), stdin);

			if (VerifPassword(buf)) {
				Admin = 10;
			}
			else {
				printf("Mot de passe incorrect.\n");
				ViderBuffer();
			}	
		}

		else if (strncmp(buf, "non", 3) == 0) {
			Admin = 2;
		}
		else {
			ViderBuffer();
		}
	} 
	
	if (Admin == 10) {
		ShellAdministrateur();
	}

	return Reponse;
}


int InputJourNaissance() {
	char buf[50];
	int JourNaiss, c = 0;

	printf("\n\nEntrez votre jour de naissance au format numérique : ");
	fgets(buf, sizeof(buf), stdin);
	while (!EstEntier(buf) || atoi(buf) > 31 || atoi(buf) < 1) {
		printf("Erreur en entrée.\n");		
		ViderBuffer();
		printf("Entrez votre jour de naissance au format numérique : ");
		fgets(buf, sizeof(buf), stdin);
	}
	sscanf(buf, "%d", &JourNaiss);

	return JourNaiss;
}


int InputMoisNaissance() {
	char buf[30];
	int MoisNaiss, c = 0;

	printf("Entrez votre mois de naissance au format numérique : ");
    fgets(buf, sizeof(buf), stdin);
	while (!EstEntier(buf) || atoi(buf) > 12 || atoi(buf) < 1) {
		printf("Erreur en entrée.\n");
		ViderBuffer();
		printf("Entrez votre mois de naissance au format numérique : ");
		fgets(buf, sizeof(buf), stdin);
	}
	sscanf(buf, "%d", &MoisNaiss);

	return MoisNaiss;
}

int InputAnneeNaissance() {
	char buf[30];
	int AnneeNaiss, c = 0;

	printf("Entrez votre année de naissance au format numérique : ");
    fgets(buf, sizeof(buf), stdin);
	while (!EstEntier(buf)) {
		printf("Erreur en entrée.\n");
		ViderBuffer();
		printf("Entrez votre année de naissance au format numérique : ");
		fgets(buf, sizeof(buf), stdin);
	}
	sscanf(buf, "%4d", &AnneeNaiss);

    return AnneeNaiss;
}


void CalculateurAge(int JourNaiss, int MoisNaiss, int AnneeNaiss) {

	int JoursParMois[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	int jour, mois, annee;
	int AgeJour, AgeMois, AgeAnnee;
	time_t temps;
	struct tm *date;
	
	printf("\n- - - - - - - - - - -\n\nVous êtes né(e) le %d/%d/%d.\n", JourNaiss, MoisNaiss, AnneeNaiss);

	/* Recuperation de la date du jour */
	temps = time(NULL);
	date = localtime(&temps);
	jour = date->tm_mday;
	mois = date->tm_mon + 1;
	annee = date->tm_year + 1900;
	printf("Nous sommes le %d/%d/%d.\n", jour, mois, annee);
 
 
	/* Calcul de l'age en jours, mois et annees */
	AgeJour = JoursParMois[MoisNaiss - 1] - JourNaiss + jour;
	AgeMois = (12 - MoisNaiss) + mois - 1;
	AgeAnnee = annee - AnneeNaiss - 1;

	if (AgeJour > JoursParMois[MoisNaiss - 1]) {
		AgeJour -= JoursParMois[MoisNaiss - 1];
		AgeMois += 1;
	}

	if (AgeMois > 11) {
		AgeMois -= 12;
		AgeAnnee += 1;
	}

	printf("\n- - - - - - - - - - -\n\nVous avez %d ans, %d mois et %d jours.\n\n", AgeAnnee, AgeMois, AgeJour);
}

 
int main() {
	printf("\n#### Bienvenue dans notre calculateur d'âge ####");
	
	int JourNaiss, MoisNaiss, AnneeNaiss;
	int rejouer = 1;

	while (rejouer == 1) {

		JourNaiss = InputJourNaissance();
		MoisNaiss = InputMoisNaissance();
		AnneeNaiss = InputAnneeNaissance();

		VerificationFevrier(JourNaiss, MoisNaiss, AnneeNaiss);
		CalculateurAge(JourNaiss, MoisNaiss, AnneeNaiss);

		rejouer = RejouerEnregistrer();
	}

    return 0;
}
