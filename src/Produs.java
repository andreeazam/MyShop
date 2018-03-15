

public class Produs {
	int idProdus;
	String denumireProdus;
	double pretProdus;

	
	public Produs(int idProdus, String denumireProdus, double pretProdus){
		this.idProdus = idProdus;
		this.denumireProdus = denumireProdus;
		this.pretProdus = pretProdus;

	}
	
	public String toString(){
		return "Avem: "+"ID:"+idProdus+" "+denumireProdus+" "+"pret: "+pretProdus;
		
	}
	
	
}
