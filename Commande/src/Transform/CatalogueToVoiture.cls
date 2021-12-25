Class Transform.CatalogueToVoiture Extends Ens.DataTransformDTL [ DependsOn = (webObjet.wsCatalogue, webObjet.wsVoiture) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='webObjet.wsCatalogue' targetClass='webObjet.wsVoiture' create='existing' language='objectscript' >
<assign value='source.marque' property='target.marque' action='set' />
<assign value='source.modele' property='target.modele' action='set' />
<assign value='source.nbPlaces' property='target.nbPlaces' action='set' />
<if condition='source.nbPlaces=2||source.nbPlaces&lt;2' >
<true>
<assign value='source.nbPlaces_"place"' property='target.categorie' action='set' />
</true>
<false>
<assign value='source.type' property='target.categorie' action='set' />
</false>
</if>
</transform>
}

}
