public class Luftwiderstand
{
    private double VerstricheneZeit;
    private double Geschwindigkeitalt;
    private double Geschwindigkeitneu;
    private double Beschleunigung;
    private double BeschleunigungLuft;
    private double Strecke;
    private double x = 50;
    
    double Zeitschritt = 0.5;
    double Gravitation=9;
    double Masse=50;
    double Cw=0.5;
    double Fläche=0.5;
    double Luftdichte=1;
    double Anfangsgeschwindigkeit=0;
    double Höhe=300;
    //Strecke von Höhe abziehen
    
    public void TabelleRechnen(double Anfangsgeschwindigkeit)
    {
        Geschwindigkeitalt = -1*Anfangsgeschwindigkeit;
        
        while(x>0)
        {
            VerstricheneZeit = VerstricheneZeit + Zeitschritt;
            Geschwindigkeitneu = Geschwindigkeitalt + Beschleunigung*Zeitschritt;
            Strecke = Strecke + 0.5*(Geschwindigkeitneu + Geschwindigkeitalt)*Zeitschritt;
            Geschwindigkeitalt = Geschwindigkeitneu;
            BeschleunigungLuft = (1/(2*Masse))*Cw*Luftdichte*Fläche*Geschwindigkeitneu*Geschwindigkeitneu;
            Beschleunigung = BeschleunigungLuft-Gravitation;
            x--;
            System.out.println(" Strecke: " + (Höhe+Strecke) + " Zeit: " + VerstricheneZeit + " Tempo: " + Geschwindigkeitneu + " Beschleunigung: " + Beschleunigung + " BeschleunigungLuft: " + BeschleunigungLuft);
        }
        VerstricheneZeit = 0;
        Beschleunigung = 0;
        Geschwindigkeitalt = 0;
        Geschwindigkeitneu = 0;
        Strecke = 0;
        BeschleunigungLuft = 0;
        x = 50;
    }
}

//double Zeitschritt, double Gravitation, double Masse, double Cw, double Fläche, double Luftdichte, double Anfangsgeschwindigkeit, double Höhe
