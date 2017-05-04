---
title: "The Logic of Alliance Formation Among Rebel Groups"
author: "David Bowden"
date: "March 1, 2017"
output:
    bookdown::pdf_document2:
        includes:
            in_header: preamble.tex
documentclass: article
bibliography: /Users/david/Box Sync/library.bib
fontsize: 12pt
fontfamily: tgpagella
geometry: margin=1in
numbersections: true
toc: no
abstract:
    "Multi-party civil wars are among the most severe conflicts, yet we know relatively little about the determinants of rebel movement structure. I focus on a key aspect of this process - the conditions under which rebel groups are likely to form alliances. I argue that rebel groups will prefer alliances with groups that have similar non-sectarian ideologies, and dissimilar sources of material support. Groups with dissimilar ideologies or rival claims for support bases such as natural resources or an ethnic constituency should be unlikely to collaborate. I test this theory using data on alliances between 29 militant organizations in the Syrian civil war. Using an TERGM model of network formation, I show that ideological similarity indeed is a strong predictor of alliance formation. However, I find that groups competing for similar territories, natural resources, or the representation of the same religious minority are not any less likely than others to form alliances. These results call into question existing theories that expect alliances to be formed primarily on the basis of relative power."
---

 

\doublespacing


# Introduction

Theories of civil war tend to focus on individual- or group-level motives [e.g. @gurr70; @Collier2004] or opportunities [e.g. @fearonlaitin03] for rebellion, while giving little attention to the organization of dissent into rebel groups and coalitions. Even those studies which do explicitly consider rebel group formation tend to focus on group attributes such as discipline [e.g. @Weinstein2007], and do not consider the possibility that rebels do not always form a single group. Yet, 44% of civil conflicts feature at least two rebel groups challenging the government.^[Source: @Pettersson2015a.] Over the course of the Chadian Civil War, for instance, 25 distinct rebel groups fought against the government. Conflicts in Afghanistan in the 1980's, Somalia in the 1990's, and Sudan in the 2000's have been similarly complex. The ongoing civil war in Syria is contested by at least two dozen armed groups. Even ethnically-homogeneous, geographically-concentrated movements with common goals, such as the Karen secessionist campaign in Myanmar, often fragment into multiple rebel groups. Furthermore, the number of groups operating in these conflicts often varies greatly over time. The existing literature offers many useful insights to the conditions under which civil war will emerge, but it has few explanations of the structure of rebel movements.

While little attention has been given to the sources of rebel movement structure, several studies suggest that such configurations can have deleterious consequences. Conflicts with multiple rebel groups last longer than dyadic competitions [@Cunningham2006; @Cunningham2009; @Akcinaroglu2012a]. Furthermore, @Cunningham2009 find that the presence of multiple government-rebel dyads decreases the likelihood of peace agreements and increases the likelihood of rebel victories, though @Findley2012, find that fragmented rebel movements are often associated with an *increased* likelihood of negotiated settlement. Relatedly, @Atlas1999 and @Zeigler2016  find that episodes of conflict renewal often occur between formerly allied rebel factions. Finally, conflicts with multiple dyads feature more fatalities than dyadic ones.^[Source: my own analysis using data from @Sundberg2008a.] Clearly, conflicts with multiple rebel groups comprise one of the most severe subsets of civil wars. Thus, understanding the causes of multi-dyadic conflict is of great normative and policy importance.

I seek to address this gap by explaining one of the primary determinants of rebel movement structure --- the formation of alliances between rebel factions. Which rebel groups are likely to form alliances? With whom are they likely to ally? While alliances cannot account for all of the variation in the number of rebel groups in a conflict --- the fragmentation of existing groups and the entry of previously non-violent groups to the conflict are also important processes --- alliance ties tend to predict deeper integration between rebel groups. Many rebel alliances evolve into umbrella organizations with shared command, and weak rebel groups are frequently absorbed by alliance partners. Thus, alliance formation is a crucial determinant of whether conflicts become less complex over time.

First and foremost, this work advances our understanding of the complexity of civil conflict in terms of the number and arrangement of actors. This builds on the growing literature on another facet of complexity --- the fragmentation of existing groups [see @Cunningham2009; @Pearlman2011a; @Staniland2014] --- and presents contrasting evidence to the few existing studies of rebel alliances [@Christia2012; @Bapat2012], which focus on relative capability as the key driver of coalition building. Furthermore, examining the relationships between rebel groups sheds new light on debates about the motives behind rebellion [e.g. @Collier2004]. For instance, if rebellion is fundamentally about ethnic or religious grievances, we might expect to see the emergence of coalitions with homogeneous identities. If, by contrast, rebels are motivated by the desire for profits from natural resources or illicit activities, we might see groups with access to such revenues seek to limit the number of combatants with whom they share their spoils, irrespective of common identity.

I proceed with a review of the literature on relations between rebel groups. Next, I outline the potential benefits rebels might receive by forming alliances. Subsequently, I explore the conditions under which rebels will elect to engage in such cooperation. Finally, I present results from an inferential network model applied to the Syrian Civil War.

<!-- I proceed with a more detailed discussion of this project's contributions to the existing literature. Subsequently, I articulate a theoretical framework that establishes the set of dissidents from which rebel groups emerge. Next I offer a theory relating the structure of this dissident network to the number of rebel groups that participate in a conflict, followed by a theory of what shapes the dissident network itself. After detailing a research design for testing these propositions, I provide two pilot studies. The first demonstrates the dissident network approach in the context of the Israel-Palestine conflict. The second uses a panel analysis to identify a link between international support, a factor that I argue is an important determinant of the evolution of the dissident network, and the formation of new rebel groups. -->


# Relations Among Rebels

Relations among rebel groups remains one of the most underexplored aspects of civil war. The vast majority of existing studies focus on conflict between non-state actors. A few studies have, however, examined conflict between rebel groups. In the most comprehensive study to date, @Fjelde2012 suggest that rebels fight each other for control over resources such drug supplies or valuable terrain. Greater resource endowments should lead to better postwar bargains with the government in the long run, and greater ability to sustain a rebellion in the short run. The authors find that this logic is most likely to prevail in the presence of natural resources, territories that are not controlled by the government, militarily weak governments, and significant power asymmetries among rebels. @Atlas1999 and @Zeigler2016 find that this dynamic can also arise in the aftermath of conflicts, as the main fighting in renewed civil wars is often between previously allied rebel groups.

Another strand of literature examines the emergence of conflict within previously coherent movements. @Bakke2012a conceptualize the fragmentation of rebels movements as varying in terms of the raw number of organizations, the degree of institutionalization unifying the organizations, and the distribution of power among them. They expect a greater general likelihood of infighting in more fragmented movements, particularly those with large numbers of groups and low degrees of institutionalization. @Asal2012 find evidence that largely supports this claim, showing that ethnopolitical movements with factionalized leadership structures are most likely to experience splits. Similarly, @Cunningham2012a find that infighting is most likely in self-determination movements with large numbers of factions, and that the emergence of new factions is especially likely to trigger violence. @Staniland2014 similarly emphasizes pre-existing social structure, arguing that the probability of an insurgent group splintering is shaped by the strength of social ties in the organization from which it emerged. Others see infighting as contingent on the conflict process. @Christia2012 finds that rebel groups and coalitions tend to fragment when battlefield losses exacerbate divisions between faction leaders, while @McLauchlin2012 find that repression can deepen rifts within movements that are already divided, but cohesive movements may become further solidified by repression.

There is also a substantial literature on intra-ethnic violence. @Lilja2011 find that that Tamil rebels used violence against co-ethnic civilians to control populations and the resources they hold, and against coethnic armed groups to establish dominance within the ethnic group. @Staniland2012d finds that these patterns intra-ethnic violence tend to be self-reinforcing, as violence within ethnic insurgencies is the primary cause of the defection of some subsets of ethnic groups to the opposing side in the conflict. [@Warren2015] seek to explain which ethnic groups are likely to experience such fragmentation, finding a curvilinear relationship between the size of an ethnic group and its probably of experiencing infighting. Small ethnic groups have the ability to police themselves, limiting violence, and intra-ethnic violence in large groups is likely to be met with government intervention. Thus, only moderate-sized groups tend to experience internal violence.

Finally, a few studies consider the formation of alliances among various types of militant organizations. @Asal2008 and @Horowitz2013 conduct network analyses of alliance formation among terrorist groups, arguing that such arrangement are used to aggregate capabilities and share tactics. @Bapat2012 model the logic of alliance formation among rebel groups. They assume that alliances carry two significant costs: the dilution of each constituent group's agenda, and the risk of having one's private information sold to the government by an ally. Consistent with this theory, they find alliances to be most common when an outside state can enforce agreements, and when all rebel groups involved are strong enough to avoid the temptation of defecting to the government side @Christia2012 similarly emphasizes capability, arguing that neorealist balancing theory from international relations explains alignments in civil wars. When one coalition - a group of rebels or government-aligned forces - becomes too powerful, other groups will band together to prevent their own destruction. But similar @Bapat2012, @Christia2012 argues that this mechanism is constrained by a desire to maximize one's share of the post-war spoils. Thus, rebels realign frequently, seeking to form minimum winning coalitions. While shared identity appears on the surface to be an important determinant of rebel alignments, Christia views these narratives as post-hoc justifications aimed at legitimizing decisions that are really driven mostly by power. Some important aspects of alliance formation are beyond the scope of the existing studies, however. Namely, while relative power considerations can potentially account for why rebel groups form alliances, and when they will alter their ties, it does not explain why groups choose a particular partner when multiple options are available. Christia suggests that these decisions are shaped by personal relationships between rebel elites, but does not give this question extended consideration in her empirical analysis. @Horowitz2013 find that militants prefer to ally with powerful groups, but their focus is largely on transnational networks of terrorists and insurgents, rather than alliance formation within a particular conflict. I seek to resolve this gap by explaining not only whether, but also with whom rebel groups will choose to form alliances.


# A Theory of Rebel Alliance Formation

## Rebel Factions and Their Interests

I start from the assumption that governments in civil wars are opposed by one or more dissident factions. I define a faction as a set of people with relatively homogeneous beliefs and identities, that is capable of acting as a group. For example, a communist party might have Leninist and Maoist factions, and an ethnonationalist movement might have Christian and Muslim factions. Faction members likely will not share identical beliefs on every political question, and may not have identical racial, ethnic, or religious backgrounds. This might be especially true of factions organized around loyalty to a specific individual or locale. A faction will, however, tend to be unified on the most salient political and identity issues of the moment.

In some contexts, the faction may not be an appropriate unit of analysis. For example, rebel groups often do engage in recruiting new members on an individual basis, and an individual-level approach would be appropriate for studying such a phenomenon. For the formation and restructuring of rebel groups, however, decisions tend to be made by collectives. @Staniland2014 argues that rebel groups tend to emerge from existing organizations, rather than spontaneous collections of individuals. My own data collection shows similar patterns, with 97% of rebel groups since 1946 having origins in a pre-existing organization. When rebel groups fragment, abandonment of the existing group is often done by entire sub-units. For example @Staniland2014 finds that fragmentation often takes the form of local brigades breaking away from a central organization, as was the case for with al-Qaeda in Iraq, which saw many local Sunni militias defect and begin cooperating with the US. Similarly, @Christia2012 sees realignment as being driven by mid-level rebel commanders, who generally take a cadre of loyal forces with them when initiating and breaking alliances.

Factions can structured in a variety of arrangements during a conflict. A faction can resort to violence on an individual basis, resulting in a rebel group with mostly homogeneous preferences and identities. In other cases a faction may ally with others to former a larger, but more heterogeneous rebel group. Finally, factions may remain non-violent, using peaceful tactics to oppose the government. These arrangement are dynamic, however. Previously independent factions may form alliances, previusly aligned factions may choose to break alliances, previously non-violent factions may choose to enter a conflict, and previously violent factions may choose to demobilize. I argue that two broad concerns shape each these decisions.

First, I assume that factions have genuine political interests. This assumption is not necessarily obvious in light of the long-running debate as to whether rebellion is motivated by public or private concerns [see @Collier2004]. Indeed, some scholars have gone as far as to posit that rebellion is little more than glorified criminal activity aimed at controlling natural resources and illicit trades [@mueller00], or that individual participation is often motivated by a desire to settle personal disputes [@Kalyvas2006]. I do not reject the notion that rebels value such things (indeed, see the second assumption below); I simply contend that greed and grievance are a false dichotomy. Most rebel groups articulate a political platform of some variety. This might take the form of a comprehensive ideological program such as a communist revolution, or a more narrow concern such as land reform or self-determination for a particular ethnic group. While earlier work found greater support for the greed hypothesis, suggesting that such political rhetoric is merely a veneer on more selfish motives, recent studies using higher-quality data have found that political grievances, and particularly ethnic discrimination, to be among the strongest predictors of civil war [@Cederman2010].

Second, however, I expect that factions will seek to maximize their individual power. Even if rebels are primarily motivated by political interests, material resources are an important means to achieving such goals. A faction's influence in any postwar order is likely to be shaped in large part by its power. If a faction retains enough fighting capability to re-open violence, other actors interested in peace will have an interest in accommodating many of their demands. Relatedly, a faction will have difficulty trusting any concessions it wins from more powerful actors. Thus, retaining capability at the end of a conflict is likely to be advantageous with respect to advancing one's political goals [@Nygard2014]. Furthermore, greater power allows a faction greater autonomy from fellow rebels. Political power is a finite good, and as a group's capabilities increase, the number of other rebels with whom they must share it decreases [@Christia2012; @Bapat2012]. Finally, even if it is not their primary motive, rebels do use material resources to incentivize recruitment and retention efforts [@Weinstein2007], and to enrich top leadership.


## The Value of Rebel Alliances

Frequently, rebel factions engage in military collaboration with other non-state actors. This can range from an agreement not to target each other, to a divisions of territory, to joint campaigns on the battlefield, to full mergers. These alliances can be valuable for a number of reasons. First, alliances aggregate capabilities. This is perhaps the most common conception of alliances in international politics [see @Bennett1997], and it has been proposed as a motive for rebel alliances as well [@Bapat2012; @Horowitz2013. The logic of capability aggregation differs somewhat between international and civil conflicts. Whereas international alliances aggregate capabilities by bringing states into a conflict in which they might not otherwise participate, rebel groups by definition are already participating in conflict. Nevertheless, these alliances can bring great value because rather than simply aggregating, they can concentrate capabilities in space and time. For example, two rebel groups might be unable to capture a government-held town on their own, but in a joint operation would be sufficiently powerful to do so. 

Second, alliances can allow for burden-sharing and specialization. Burden-sharing has been offered as an explanation for international alliances such as NATO [@Sandler1980], though it may not occur under all circumstances [see @Olson1966]. Alliances can ensure that a single rebel group is not responsible for defeating the government, and might serve as a mechanism for reigning in the temptation to free ride off of another group's efforts. Relatedly, alliances can facilitate specialization by rebel groups. For instance, one alliance partner might specialize in holding territory, while another specializes in launching offensives in new areas. Furthermore, they can share strategies and technical information. For example, Hamas is believed to have learned how to use suicide bombings through its alliance with Hezbollah [@Horowitz2013].

Third, alliances can manage conflict between members and ensure that their resources are directed toward common enemies. @Weitsman1997 argues that alliances often serve to tether powerful states to one another, so as to reduce the probability of conflict between them. @Gibler1996 finds that alliance treaties are often used to settle territorial disputes between the signatories. Similar alliances can be seen in civil wars, for example as a number of Syrian rebel groups agreed to focus their efforts in different regions of the country. This allows rebels to avoid conflict with each other. Compliance with such agreements is incentivized by the fact that reneging on the territorial arrangement would likely result in the loss of the other benefits of the alliance, such as capability aggregation.

Fourth, operating as an alliance bloc may be beneficial to the members groups in bargaining situations. An alliance with a set of coordinated demands might command greater bargaining leverage than individual members, who collectively have similar power, but a more disparate set of demands. Perhaps more crucially, alliances might mitigate credible commitment problems. Peaceful settlements to conflicts can be derailed by concerns that the other side will not adhere to the agreement [@fearon95]. In civil wars, this is often borne out by extreme "spoiler" factions. A rebel commitment to a peace agreement is more likely to be viewed as credible if it has formal control over other factions.

## The Costs of Alliances

While the benefits are often many, most alliances between rebel groups are not without cost. The post-war political outcome, whether it comes in the form of a rebel victory or a compromise with the incumbent government, is likely to be shaped by all factions within the winning coalition. Thus, allying with another group holding differing ideologies and interests will tend to force a rebel faction to compromise on at least some issues, or to de-emphasize certain priorities. If, as I assume, rebels are motivated by political goals, the value of an alliance will decrease as its ideological similarity to its alliance partners decreases [@Bapat2012]. Furthermore, any private benefits deriving from the conflict outcome (such as seats in a post-war legistlature) must be divided among the members of the winning alliance [@Christia2012]. These concerns should tend to constrain the value of alliances in civil war. The existing literature finds that these concerns limit the size of rebel coalitions [@Christia2012]. Logically, they should also shape the choice of partners with whom rebels ally.

## The Choice of Alliance Partners

I expect that the decision to form an alliance with a particular group is shaped by two broad considerations. The first is the ideological similarity of the two groups. The second is the potential gain in capability. Consistent with the existing literature, I view the current material capabilities of a potential ally as a crucial factor, with more powerful groups making more attractive alliance partners. I depart from the literature [e.g. @Christia2012], however, by also considering the importance of access to future sources of power. Specifically, I expect that a group will evaluate a potential alliance partner not only on its current level of capability, but also on the extent to which the group is a rival for access to future sources of power, such as natural resources or civilian populations. In other words, a rebel group with enough power to normally be an attractive partner may not be if it's strength is drawn from similar support bases as one's own group. By contrast, a relatively weak group with a completely non-overlapping support base might be an attractive ally.

A rebel group's support base is shaped by a mix of external factors such as the presence of natural resources and foreign sponsors, as well as its objectives. Some ideological objectives provide rebel groups with somewhat malleable support bases, such as those that entail the provision of public, non-rival goods to society. It is comparatively easy for groups of this sort to minimize the overlap between their support bases. By contrast, rebels that pursue private, rival goods or interests specific to certain societal groups are likely to be in competition with rebels advancing similar objectives. In the remainder of this section I classify various rebel objectives on this dimension.

Most non-sectarian ideological interests should fall into the category of public, non-rival goods. If two groups each prefer a similar goal, such as a redistributive welfare system, a greater role for Islam in government, or a devolution of power to regional governments, they will be able to enjoy the benefits of such policies regardless of which group enacts them. All else equal, goals of this sort should create common interests among the rebels who share them. Furthermore, policies of this sort tend not to have pre-defined constituencies. A rebel group based on ideology could potential convert new members or civilian supporters to its cause by spreading its beliefs. As ideologies of this sort are generally not tied to a specific ethnicity, religion, or geographic area, the pool of potential converts is quite large. Thus, groups centered around ideologies of this sort should have high potential for cooperation, as they are relatively unlikely to be rivals for support. The value of cooperation will be especially high for groups that have similar non-sectarian ideologies.

*H1: Rebel groups with similar non-sectarian ideologies should be more likely to form alliances than other rebel dyads*

<!-- *H2: More powerful rebel groups will be less likely to form alliances than weaker ones* -->

While groups with similar non-sectarian interests should tend not to come into competition until late in conflicts, for groups representing identity-based interests, the effect is contingent on the size of the group and malleability of group boundaries. The reason for this lies in the fact that many rebel groups rely on civilian populations for material support [@Weinstein2007], and the types of goals a group pursues is an important determinant of the malleability of civilian support coalitions. A group with broad-based policy goals might be able to persuade or coerce almost any group of citizens to support it. Thus, until a very large portion of the civilian population has been captured, groups sharing these types of goals will not be in competition over support as they can simply carve out different coalitions. Similar dynamics should occur among groups pursuing the interests of large or social groups, such as the majority ethnic or religious group. For example two Syrian rebel groups seeking to replace the Alawite-dominated Assad regime with one that embraces Sunni doctrine should find that civilian support is not particularly scarce given that Syria is majority-Sunni. Similarly, groups advocating the interests of social groups with fluid boundaries should tend to have opportunities to capture new civilian support rather than competing with similar groups over existing support. For instance, for a group advocating a Salafi-Jihadi ideology, any Sunni Muslim might serve as a potential convert.

Rebels representing minority social groups, however, should tend to come into conflict more quickly. Groups of this sort must draw their support from a social base that is both smaller and more likely to be tapped out than the bases of more broadly defined groups, and that is more rigidly bounded. A rebel group aimed at advancing the interests of a particular ethnic or religious group is unlikely to attract support from non-group members. Even if it was able to do so, this might its standing with co-ethnics/co-religionists, as rival groups could claim that it is watering down its agenda. In other words, socially-defined rebel groups seeking to expand the pool of potential support might be vulnerable to outbidding appeals. In short, I expect that groups with the agenda of advancing the interests of majority ethnic or religious groups will be  likely to cooperate with groups holding similar interests. Groups representing social minorities, however, should be unlikely to cooperate.^[In the present analysis, however, the Kurds are the only group to whom this logic is likely to apply, and thus I do not test this hypothesis as it would essentially be a dummy variable for the one Kurdish-Kurdish dyad.]

*H2: Rebel groups representing the same majority ethnic or religious groups will be more likely to form alliances than other dyads*

Groups seeking to control the same territory should face a similar problem of rival consumption. Because secessionist claims tend to have well-defined geographic and/or ethnic boundaries, rebel groups representing such claims are likely to be in competition over a fixed pool of support. Thus, I expect that groups making similar territorial claims will be unlikely to cooperate.

*H3: Rebel groups with overlapping territorial claims will be less likely to form alliances than other dyads*


# Research Design

To test these hypotheses, I use data on rebel interactions during the Syrian Civil War. The war in Syria began in March 2011 and continues through the present, and provides a rich environment for studying rebel alignments as it is one of the more complex conflicts in the post-WWII era. The conflict is characterized by numerous loose coalitions, which are often made up of several largely autonomous brigades, each with their own name and support base. Several such brigades have split from their parent organizations to become independent, and others have defected to rival groups. Because of this decentralized structure, estimates of the number of groups active in the conflict vary wildly. If one counts each brigade as a separate organization, their number likely surpasses two dozen, and may well be in the hundreds.^[See BBC News, "Guide to the Syrian Rebels" [http://www.bbc.com/news/world-middle-east-24403003](http://www.bbc.com/news/world-middle-east-24403003).] In the data employed here, I only consider fully autonomous organizations (i.e. those that are not subsidiaries of other groups). I do this in part for practical reasons, but also because generally lack the ability to engage in lasting cooperation with other groups, separately from the decisions made by the parent organization. If a faction splinters from its parent and becomes independent, however, they enter the data. This definition yields a set of 29 organizations that are active at some point in the conflict.

## The Data

I employ a compilation of existing and original data that on the Syrian conflict. The data cover the period March 15, 2011 to September 30, 2016, and as noted above, includes the 29 non-state actors that are clearly independent from other groups at some point during the conflict.^[Some became independent by splitting from a parent organization, and others were independent at some point but were later absorbed by a larger organization.] This includes all non-state actors that have engaged in violence in Syria. Thus several groups that did not originate in Syria are included, such as Hezbollah (Lebanon) and the Islamic State (Iraq). It should be noted that I include several actors that have to this point fought mainly on the side of the government, including Hezbollah and several Iraqi Shiite groups. I do this for two reasons. First, there are numerous cases of pro-government actors defecting to the rebel side, and vice-versa [@Staniland2012d]. Second, while the conflict between the Assad regime and various rebels is obviously a central dimension of the war, in many locales the primary opponent for rebels is the Islamic State (IS). Thus it is quite conceivable that these pro-Assad actors might form alliances with anti-Assad forces, either due to a realignment in the conflict, or more likely, to fight against IS. Excluding such organizations does not substantially alter my results.

The primary source of the data is the Stanford Mapping Militant Organizations Project^[[http://web.stanford.edu/group/mappingmilitants/cgi-bin/](http://web.stanford.edu/group/mappingmilitants/cgi-bin/)], which I used to define the universe of independent rebel groups, and provided the majority of the alliance ties in the data. I supplement this with my own codings of additional alliances and several covariates based on news articles procured through LexisNexis and reports from think tanks including the Institute for the Study of War and the Carter Center. The complete list of included groups is presented in Table \@ref(tab:members) and the network of alliances is plotted in Figure \@ref(fig:networkplot). As the figures make clear, the pattern of alliances changes considerably over time, with many new alliances forming over the course of the conflict, and several existing alliances crumbling.



\begin{table}[ht]
\centering
\begin{tabular}{ll}
  \hline
Group Name & Abbreviations \\ 
  \hline
Badr Organization of Reconstruction and Development & Badr \\ 
  Kata'ib al-Imam Ali & KIA \\ 
  Kata'ib Sayyid al-Shuhada & KSS \\ 
  Asa'ib Ahl al-Haq & AAH \\ 
  Harakat al-Nujaba & HN \\ 
  Kata'ib Hezbollah & KH \\ 
  Hezbollah & Hez \\ 
  Jaysh al-Sanadeed & JS \\ 
  The Peoples Protection Units & YPG \\ 
  Harakat Nour al-Din al-Zenki & HNDZ \\ 
  The Southern Front & SF \\ 
  The Islamic State & IS \\ 
  Al Qaeda & AQ \\ 
  Jabhat Fatah al-Sham & Jabhat \\ 
  Jund al-Aqsa & JA \\ 
  Kurdish Islamic Front & KIA \\ 
  Ahrar al-Sham & AhS \\ 
  Liwa al-Haqq & LH \\ 
  Ansar al-Sham & AnS \\ 
  Al-Fawj Al-Awl & AFAA \\ 
  The Levantine Front & LF \\ 
  Liwa al-Tawhid & LT \\ 
  Jaysh al-Islam & JI \\ 
  Liwa al-Islam & LI \\ 
  Suqour al-Sham & SS \\ 
  Jaysh al-Sham & JaS \\ 
  The Free Syrian Army & FSA \\ 
  Faylaq al-Rahman & FR \\ 
  The Ajnad al-Sham Islamic Union & ASIU \\ 
   \hline
\end{tabular}
\caption{Non-State Actors in the Syrian Civil War} 
\label{tab:members}
\end{table}

## Dependent Variable

My dependent variable is military cooperation between rebel groups.^[Technically, as noted below, it is the network of military cooperation between rebel groups.] This includes three types of relationships. One is battlefield coordination, which is defined as one or more instances in which two groups attack the same opponent at the same place and time, and in which there is evidence of joint planning. Second are explicit statements of alliance, which could entail high degrees of integration, such as the formation of umbrella organizations, or less formal statements of common goals or enemies or agreements to provide military aid. Finally, a few groups are connected through formal affiliations. For example, until earlier this year, Jabhat al-Nusra was the Syrian affiliate of al-Qaeda.

![Alliances in the Syrian Civil War](figure/networkplot-1.png)

## Independent Variables

*Rebel Goals* Hypotheses 1 and 3 expect that alliances should be most likely between rebel groups that share similar goals, with the effect differing depending on the type of goal. I thus code the primary goal of each group, which are coded from manifestos, public statements, and group websites. This coding is highly specific to the Syrian context, and takes on one of the following values. Groups with "moderate" aims seek to overthrow the government, but tend to have few other strongly-held beliefs. "Islamist" groups seek to give Islam a greater role in public life, but under my definition do not aim to fundamentally change the boundaries of the polity. "Jihadist" groups are essentially a more extreme version of Islamists --- they adhere to strict interpretations of holy texts, and tend to be more accepting of extremist tactics such as terrorism and civilian targeting. Still more extreme are groups pursuing a "Caliphate" --- while they may share many beliefs with Islamists and jihadists, these groups differ in that they aim to replace the existing polity with an Islamic Caliphate covering a much broader area. Finally, there are two categories of groups primarily aimed at advancing identity-based interests: "Shiite Interests" and "Kurdish Interests."

*Troop Strength* @Horowitz2013 find that more powerful militant groups tend to have more allies. To account for this, I include estimates of the number of troops each rebel group has at their disposal. Unfortunately this is a static measure, as for most groups estimates are available only once or twice.

*Predominant Religion* I code the predominant religion in each group, distinguishing between Sunni and Shia Muslims. When the demographics of the broader group are not available, I make a coding based on the group's leadership.

*Territorial Aims* I code a binary indicator of whether a group seeks control of a territorial unit other than the current configuration of the state. For instance, a Kurdish state or Caliphate.

*Political Wing* I include an indicator of whether a group in engages in non-violent political activity. This can include running candidates in elections, as Hezbollah does, or governing a territorial area, as IS does. This variable might proxy for the centrality of political goals to a group's mission, and may account for alternative mechanisms of alliance formation, such as participation in a government in exile.

*Same Sponsor* @Bapat2012 find that outside states can facilitate cooperation by enforcing alliance agreements. I thus include a control for whether the members of a dyad share the same external sponsor. I code this variable as 1 if states receive support from at least one of the same outside states, and 0 otherwise.

*Same Region* Given that battlefield collaboration accounts for a significant portion of the network ties in my data, it stands to reason that groups operating in the same regions will be more likely to cooperate than groups separated by physical distance. I code this measure as 1 if the members of a dyad have been involved in battles in at least one of the same regions (Eastern, Western, and Southern Syria, and Iraq), and 0 otherwise.

*Same Civilian Targeting* A potential dividing line among rebels aside from ideology and identity is treatment of civilians. I include a dummy variable indicating whether the members of a dyad have the same treatment of civilians. It is coded as 1 if both have documented instances of violence against civilians, or neither have, and 0 if they differ on this question.

*Natural Resources* Access to natural resources may alter a group's participation in alliances, as they are a power base that is subject to rival consumption. Indeed, rebels often fight over control of resources [@Fjelde2012]. I use a binary indicator to control for the effect of access to oil and drugs on a group's propensity to form alliances.

*Foreign Fighters* The ability to draw recruits from abroad reduces the likelihood that a group will be in competition with others, and increases the likelihood that they will participate in alliances. I code this variable as a 1 if the groups draws at least a portion of its recruits from abroad, and 0 otherwise.

## The Model

To make statistical inferences about the determinants of the Syrian alliance network, I employ an extension of the increasingly popular Exponential Random Graph Model (ERGM). The ERGM uses Monte Carlo Markov Chain maximum likelihood estimation to assess the effect of various actor attributes and network dependencies on the formation of the observed network. Ultimately, it allows one to make inferences about the probability of a tie between two nodes given the values of their covariates. As I have a network that is observed annually for six years, I use the Temporal Exponential Random Graph Model extension, which allows one to control for temporal dependence in network ties. The network approach is necessary because a standard regression model likely could not account for dependence between dyads. For example, if actors A and B share ties and A and C share ties, the probability of a tie between B and C is likely not independent of the other two decisions. The TERGM can account for these sorts of dependencies.

I treat alliances as undirected ties. I include parameters for several network effects that might account for the observed structure. This includes a triad effect to account for the propensity fully closed triads in the network (i.e. connections between A, B, and C). In addition I account for the propensity toward three trails --- connections between three nodes (i.e. i is connected to j, and j is connected to k). Finally, I account for the number of two stars --- open triads in which i is connected to j and j is connected to k, but k is not connected to i. Numerous other network effects, such as the geometrically weighted edgewise shared partner distribution, were considered but were found to be not statistically significant.


# Results

The results are presented in Table \@ref(tab:models), and in Figures \@ref(fig:regplot1)-\@ref(fig:regplot3). The TERGM estimates are logged odds ratios, and thus can be interpreted in an identical way to logit estimates (i.e. by exponentiating the coefficients). Bootstrapped 95% confidence intervals are in parentheses. Model 1 includes measures of whether the members of each dyad share the same value on various measures. Model 2 disaggregates the political objective variable into specific categories, to examine whether any particular goals drive the relationship. Model 3 replicates Model 1, but excludes the pro-government militant groups such as Hezbollah.

Hypothesis 1 predicts that groups with similar political objectives will be more likely to form alliances than other dyads. I am able to reject the null hypothesis in this case, as the 'Same Goal' coefficient is positive and statistically significant in Models 1 and 3. Furthermore, the substantive effect is large. Alliances are quite rare among groups without similar goals - a probability of just 0.02 (based on Model 1). Moving from having differing goals to the same goals raises the probability to 0.14. Model 2 suggests that this relationship is driven by Jihadist dyads. Shared goals of a caliphate or Islamist policies do not have a statistically significant relationship with alliance ties, while shared Jihadist goals have positive and significant relationship with alliances.

Hypothesis 2 predicts that groups representing the same social group should be likely to have ties. As there is very little ethnic diversity among the Syrian rebels, I examine the role of shared religious identities. This coefficient is not statistically significant in either Model 1 or Model 3. Thus I fail to reject the null for Hypothesis 2. This is likely a reflection of the fact that there is not a high degree of diversity in the Syrian conflict. Most rebel groups are predominantly composed of Sunni Muslims, and thus religion is perhaps not a particularly salient consideration in alignments. This analysis should be replicated in other cases that feature greater ethnic or religious diversity before this hypothesis is considered to be definitively falsified.

Finally, Hypothesis 3 predicts that groups claiming specific territories in pursuit of secessionist or irredentist goals will be unlikely to form alliances. The 'Both Territorial Aims' variable in Models 1 and 3 and the 'Both Caliphate' variable in Model 2 each should capture this dynamic. None of them are statistically significant, however. It would seem that some dyads with territorial aims are able to form alliances, leading to the null result. One interpretation with regards to my theory is simply that more nuance is needed, as some factor might allow certain dyads to overcome the incentives against cooperation. One of the alliances accounting for this pattern is between former al-Qaeda affiliates IS and the Nusra Front. It should be noted that the two groups have become enemies in recent years, and thus my prediction might hold true on a more limited subset of the data.


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<table cellspacing="0" align="center" style="border: none;">
<caption align="bottom" style="margin-top:0.3em;">TERGM Models of Alliance Formation</caption>
<tr>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b></b></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 1</b></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 2</b></th>
<th style="text-align: left; border-top: 2px solid black; border-bottom: 1px solid black; padding-right: 12px;"><b>Model 3</b></th>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Edges</td>
<td style="padding-right: 12px; border: none;">-6.31<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">-5.02<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">-4.22</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-8.76; -4.15]</td>
<td style="padding-right: 12px; border: none;">[-7.36; -3.96]</td>
<td style="padding-right: 12px; border: none;">[-27.23; 11.02]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Triads</td>
<td style="padding-right: 12px; border: none;">2.08<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">2.27<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">2.02<sup style="vertical-align: 0px;">*</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[1.49; 3.51]</td>
<td style="padding-right: 12px; border: none;">[1.61; 3.49]</td>
<td style="padding-right: 12px; border: none;">[0.37; 6.15]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">3 Trails</td>
<td style="padding-right: 12px; border: none;">-0.09</td>
<td style="padding-right: 12px; border: none;">-0.07</td>
<td style="padding-right: 12px; border: none;">-0.04</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.16; 0.09]</td>
<td style="padding-right: 12px; border: none;">[-0.12; 0.09]</td>
<td style="padding-right: 12px; border: none;">[-0.56; 0.02]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">2 Stars</td>
<td style="padding-right: 12px; border: none;">0.16</td>
<td style="padding-right: 12px; border: none;">-0.00</td>
<td style="padding-right: 12px; border: none;">-0.05</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-1.01; 0.72]</td>
<td style="padding-right: 12px; border: none;">[-0.92; 0.30]</td>
<td style="padding-right: 12px; border: none;">[-1.07; 0.32]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Troop Similarity</td>
<td style="padding-right: 12px; border: none;">0.34</td>
<td style="padding-right: 12px; border: none;">0.54</td>
<td style="padding-right: 12px; border: none;">0.43</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.49; 1.10]</td>
<td style="padding-right: 12px; border: none;">[-0.13; 1.17]</td>
<td style="padding-right: 12px; border: none;">[-0.36; 1.06]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Troop Strength</td>
<td style="padding-right: 12px; border: none;">-0.01</td>
<td style="padding-right: 12px; border: none;">-0.05</td>
<td style="padding-right: 12px; border: none;">-0.12</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.10; 0.08]</td>
<td style="padding-right: 12px; border: none;">[-0.12; 0.05]</td>
<td style="padding-right: 12px; border: none;">[-0.93; 0.07]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Same Goal</td>
<td style="padding-right: 12px; border: none;">1.06<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">1.60<sup style="vertical-align: 0px;">*</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[0.49; 2.69]</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[0.44; 3.70]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Both Territorial Aims</td>
<td style="padding-right: 12px; border: none;">-0.13</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">0.34</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-2.53; 2.02]</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-4.98; 22.73]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Same Religion</td>
<td style="padding-right: 12px; border: none;">0.95</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">1.11</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.56; 1.86]</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-6.98; 20.77]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Political Wing</td>
<td style="padding-right: 12px; border: none;">0.27</td>
<td style="padding-right: 12px; border: none;">-0.21</td>
<td style="padding-right: 12px; border: none;">2.77</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.25; 0.82]</td>
<td style="padding-right: 12px; border: none;">[-0.46; 0.37]</td>
<td style="padding-right: 12px; border: none;">[-4.42; 23.24]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Same Sponsor</td>
<td style="padding-right: 12px; border: none;">0.33</td>
<td style="padding-right: 12px; border: none;">1.12<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">-0.21</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.09; 0.98]</td>
<td style="padding-right: 12px; border: none;">[0.75; 2.05]</td>
<td style="padding-right: 12px; border: none;">[-1.15; 0.27]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Same Region</td>
<td style="padding-right: 12px; border: none;">1.62<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">1.25</td>
<td style="padding-right: 12px; border: none;">0.40</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[0.46; 3.37]</td>
<td style="padding-right: 12px; border: none;">[-0.11; 2.81]</td>
<td style="padding-right: 12px; border: none;">[-20.71; 5.72]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Same Civilian Targeting</td>
<td style="padding-right: 12px; border: none;">0.36</td>
<td style="padding-right: 12px; border: none;">0.33</td>
<td style="padding-right: 12px; border: none;">0.61<sup style="vertical-align: 0px;">*</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.17; 0.73]</td>
<td style="padding-right: 12px; border: none;">[-0.20; 0.67]</td>
<td style="padding-right: 12px; border: none;">[0.18; 1.29]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Natural Resources</td>
<td style="padding-right: 12px; border: none;">0.93<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">1.46<sup style="vertical-align: 0px;">*</sup></td>
<td style="padding-right: 12px; border: none;">0.28</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[0.33; 2.97]</td>
<td style="padding-right: 12px; border: none;">[0.92; 3.21]</td>
<td style="padding-right: 12px; border: none;">[-0.95; 9.24]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Foreign Fighters</td>
<td style="padding-right: 12px; border: none;">0.54</td>
<td style="padding-right: 12px; border: none;">0.61</td>
<td style="padding-right: 12px; border: none;">-1.07<sup style="vertical-align: 0px;">*</sup></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.21; 0.75]</td>
<td style="padding-right: 12px; border: none;">[-0.32; 0.91]</td>
<td style="padding-right: 12px; border: none;">[-19.84; -0.71]</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Both Caliphate</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">0.37</td>
<td style="padding-right: 12px; border: none;"></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-1.68; 2.30]</td>
<td style="padding-right: 12px; border: none;"></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Both Jihadist</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">0.27</td>
<td style="padding-right: 12px; border: none;"></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.21; 0.81]</td>
<td style="padding-right: 12px; border: none;"></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;">Both Islamist</td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">0.13</td>
<td style="padding-right: 12px; border: none;"></td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;"></td>
<td style="padding-right: 12px; border: none;">[-0.49; 1.06]</td>
<td style="padding-right: 12px; border: none;"></td>
</tr>
<tr>
<td style="border-top: 1px solid black;">Num. obs.</td>
<td style="border-top: 1px solid black;">932</td>
<td style="border-top: 1px solid black;">932</td>
<td style="border-top: 1px solid black;">409</td>
</tr>
<tr>
<td style="padding-right: 12px; border: none;" colspan="5"><span style="font-size:0.8em"><sup>*</sup> 0 outside the confidence interval</span></td>
</tr>
</table>

<!-- ```{r predprob}
library(broom)
coef1 <- tidy(m1)
prob1 <- plogis(sum())
``` -->

The controls often provide results that contrast with the existing literature. Whereas @Bapat2012 suggest that two groups receiving support from the same outside state might be especially likely to cooperate, the relationship only holds in Model 2, and is not robust to the inclusion of the variables in Models 1 and 3. @Horowitz2013 find that more powerful groups will be less more likely to form alliances than weaker groups. However, Troop Strength is not significant in any of my models, indicating that stronger groups are not any likelier than average to participate in alliances. No other control is significant in all three specifications.

For robustness I have included a one-period lag of the network ties. This does not substantially alter the results. In addition, I have explored the robustness of the results to the choice of time periods. Dividing the data into two year blocks (2011-2012, 2013-2014, 2015-2016) again yields similar results.

![Model 1 Parameter Estimates](figure/regplot1-1.png)

![Model 2 Parameter Estimates](figure/regplot2-1.png)

![Model 3 Parameter Estimates](figure/regplot3-1.png)


# Conclusion

I have argued that contrary to some theoretical treatments, rebel groups do care about political aims. This fact should lead alliance ties to be most common among groups sharing similar goals. Indeed, I find that in the Syrian Civil War, shared political goals are the single most important determinant of alliance partners. I do not find support for the notion that more powerful groups should be more likely to form alliances. While I do not find evidence of religious homophily, that may be an artifact of the limited diversity of Syrian rebels. Finally, I find a null relationship between shared territorial ambitions and alliances, where I expected a negative relationship.

The finding on the importance of political goals contrasts with multiple existing theories of rebellion. The importance of political goals contrasts with the greed model of civil war, which views rebellion as being primarily aimed at procuring private material benefits for members. It also calls into question purely power-based accounts [@Christia2012], which expect rebels to be concerned with little else but winning. In addition, these results can help us to predict the dynamics of civil conflicts. If we observe a conflict with many rebel factions, but these groups share similar goals, we might expect the movement to aggregate over time. If these groups have disparate interests, however, there is a strong possibility that the conflict will remain highly fragmented. Given the severity associated with more complex conflicts, the ability to make predictions of this sort is highly valuable.

Further research in this area is needed. My hypothesized effects may simply be conditional on factors that I have yet to account for. For example, access to material support from an outside actor should reduce competition over civilian support bases or territory. In addition, this work should be replicated in other cases. As one of the most complex civil wars on record, it is possible that the dynamics in Syria do not apply in other conflicts. Finally, future work should move beyond explaining the formation of networks and explore the effects of network structure on rebel behavior. For instance, are more densely networked rebel coalitions more resilient to anti-insurgent campaigns? Do certain tactics diffuse across rebel networks?

# References

\indent

\setlength{\parindent}{-0.2in}
\setlength{\leftskip}{0.2in}
\setlength{\parskip}{8pt}

\singlespacing
