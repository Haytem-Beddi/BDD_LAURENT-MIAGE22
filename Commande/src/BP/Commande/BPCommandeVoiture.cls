/// 
Class BP.Commande.BPCommandeVoiture Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='msg.CommandeVoitureDmde' response='msg.CommandeVoitureRpse' height='2000' width='2000' >
<context>
<property name='Voiture' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
<property name='VoitureCatalogue' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='50' />
</parameters>
</property>
</context>
<sequence xend='200' yend='1000' >
<call name='Catalogue' target='Plaque' async='1' xpos='200' ypos='250' >
<request type='Ens.Request' />
<response type='Ens.Response' />
</call>
<if name='Catalogue OK' condition='response.codeRetour="ok"' xpos='200' ypos='350' xend='200' yend='900' >
<false>
<call name='Plaque' target='Plaque' async='1' xpos='335' ypos='500' >
<request type='msg.generationPlaqueDmde' />
<response type='msg.generationPlaqueRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
<assign property="context.Voiture.plaque" value="callresponse.plaque" action="set" />
</response>
</call>
<transform name='catalogueToVoiture' class='Transform.CatalogueToVoiture' source='context.VoitureCatalogue' target='context.Voiture' xpos='335' ypos='600' />
<call name='CreerVoiture' target='Voiture' async='1' xpos='335' ypos='700' >
<request type='msg.creerVoitureDmde' >
<assign property="callrequest.voiture" value="context.Voiture" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.creerVoitureRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
<call name='Depot fichier' target='File' async='1' xpos='335' ypos='800' >
<request type='msg.pushVoitureFileDmde' >
<assign property="callrequest.voiture" value="context.Voiture" action="set" />
<assign property="callrequest.voiture.couleur" value="request.couleur" action="set" />
</request>
<response type='msg.pushVoitureFileRpse' >
<assign property="response.codeRetour" value="callresponse.codeRetour" action="set" />
<assign property="response.libErreur" value="callresponse.libErreur" action="set" />
</response>
</call>
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
