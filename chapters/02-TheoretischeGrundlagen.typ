#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi, fig-source, fig-based-on, fig-based-on-note, fig-source-note
#import "../lib/abbr.typ": abbr

= Theoretische Grundlagen <theoretischeGrundlagen>

== Architektur und Entwicklung in ServiceNow-Modulen

- 

== Generative KI in der Softwareentwicklung <genAiSoftwareentwicklung>

Um die in dieser Arbeit untersuchten Effizienz- und Qualitätseffekte einordnen zu können, ist zunächst ein grundlegendes Verständnis der zugrunde liegenden Technologie erforderlich. Unter #abbr("KI", "Künstliche Intelligenz") wird im Allgemeinen die Fähigkeit von Systemen verstanden, Aufgaben zu bewältigen, die traditionell menschliche Intelligenz erfordern.#cf(<russellArtificialIntelligenceModern2016>, page: "1f") 

Eine bedeutende Teilmenge davon stellt #abbr("GenAI", "Generative Artificial Intelligence") dar, die in der Lage ist, eigenständig neue Inhalte wie Text, Bilder oder eben Quellcode zu erzeugen, anstatt lediglich bestehende Daten zu klassifizieren oder auszuwerten. Um dies zu ermöglichen werden bereits bestehende klassifizierte Daten analysiert und auf Basis dieser Informationen neue Inhalte generiert.#cf(<euchnerGenerativeAI2023>, page: 71) In der Softwareentwicklung wird diese Fähigkeit vor allem durch die Nutzung von #abbr("LLM", "Large Language Models") unter anderem zur Code-Generierung aus natürlicher Sprache genutzt. Dieser Prozess wird als Natural-Language-to-Code bezeichnet und ist Gegenstand der hier vorliegenden Arbeit.#cf(<jiangSurveyLargeLanguage2026>, page: 2)

LLMs sind dabei eine spezifische Art eines KI-Algorithmus, die in der Lage sind vielfältige Aufgaben aus dem Bereich des #abbr("NLP", "Natural Language Processing") zu bewältigen. Zu diesen Aufgaben zählen unter anderem Textgenerierung, Übersetzung und das Beantworten von Fragen.#cf(<raiaanReviewLargeLanguage2024>, page: "26846f") 

Der Verarbeitungsprozess einer natürlichsprachlichen Eingabe beginnt damit, dass der Text in kleinere Einheiten, sogenannte Tokens, zerlegt wird.#cf(<websterTokenizationInitialPhase1992>, page: 1106) Das Modell verarbeitet diese anschließend als numerische Vektoren, um die die semantische Bedeutung der Tokens zu erfassen.#cf(<raiaanReviewLargeLanguage2024>, page: "26848")

Das zentrale Element moderner LLMs bildet dabei die Transformer-Architektur mit einem Self-Attention-Mechanismus, der es dem Modell ermöglicht, die Beziehungen zwischen allen Tokens einer Eingabesequenz gleichzeitig zu erfassen.#cf(<raiaanReviewLargeLanguage2024>, page: "26849f") Auf dieser Grundlage sagt das Modell bei der eigentlichen Textgenerierung fortlaufend das jeweils wahrscheinlichste nächste Token voraus, bis eine vollständige Ausgabesequenz entstanden ist.#cf(<raiaanReviewLargeLanguage2024>, page: "26849f") Da an jeder Stelle stets die statistisch wahrscheinlichste Fortsetzung gewählt wird, folgt daraus eine grundlegende Eigenschaft moderner Codegenerierung: Das LLM erzeugt denjenigen Code, der dem gelernten Muster am ehesten entspricht, ohne dessen funktionale Korrektheit zu garantieren.

In der praktischen Anwendung deckt GenAI-gestützte Code-Generierung heute ein breites Spektrum an Aufgaben im Softwareentwicklungsprozess ab. Neben der reinen Code-Generierung zählen dazu insbesondere die automatisierte Generierung von Testfällen, die Unterstützung bei der Fehlersuche und -behebung, die Erstellung technischer Dokumentationen sowie Vorschläge zur Refaktorisierung bestehenden Codes.#cf(<zhangSurveyLargeLanguage2026>, page: "15ff") Ebert und Louridas ordnen diese Funktionen als festen Bestandteil moderner Entwicklungswerkzeuge ein und verweisen auf die zunehmende Integration solcher Assistenzsysteme, etwa in Form von GitHub Copilot, direkt in gängige Entwicklungsumgebungen.#cf(<ebertGenerativeAISoftware2023a>, page: "32")

Besondere Relevanz erhält diese Entwicklung im Kontext von Low-Code-Plattformen. Wie Liu et al. zeigen, integrieren Anbieter wie ServiceNow #abbr("GenAI", "Generative Artificial Intelligence") zunehmend direkt in ihre Entwicklungsumgebungen, um auch die verbleibenden, skriptbasierten Anteile der Plattformentwicklung zu unterstützen.#cf(<liuEmpiricalStudyLowcode2026a>, page: 11) Im konkreten Fall von ServiceNow wird diese Unterstützung durch den ServiceNow Now Assist for Code realisiert. Dieser Assistent ist in die Entwicklungsumgebung integriert und ermöglicht Entwicklern Unterstützung in Form von Code-Generierung, -Vervollständigung sowie -Refaktorisierung und das Zusammenfassen und Erklären von markierten Codeabschnitten.#cf(<AustraliaAPIReference2026>, page: 18)

Vergleichbare Entwicklungen lassen sich auch bei anderen Low-Code-Plattformen beobachten. So beschreiben Paliwal et al. den Einsatz von GenAI in Low-Code/No-Code-Umgebungen allgemein und gehen dabei auch auf konkrete Beispiele aus der Praxis ein.#cf(<paliwalLowCodeNoCodeMeets2024>, page: 4) Des Weiteren stellen sie fest, das bei der Integration von GenAI in die Entwicklungsumgebungen von Low-Code-Plattformen besondere Herausforderungen bestehen, die sich aus der Komplexität der Plattformen und den spezifischen Anforderungen der Nutzer ergeben. So ist bei der Verwendung von GenAI in diesem Zusammenhang besonders wichtig zu beachten, das in Low-Code-Plattformen meist domänenspezifische Informationen und Best-Practices zu beachten sind.#cf(<paliwalLowCodeNoCodeMeets2024>, page: 3) Gorissen et al. untersuchen in ihrer Studie aus dem Jahr 2025 unter anderem die Erwartungen der Nutzer an die Fähigkeiten von GenAI in Low-Code-Plattformen und stellen fest, dass die Nutzer insbesondere auf Unterstützung beim Erstellen neuer Artefakte hoffen.#cf(<gorissenSupportingDevelopmentOracle2025>, page: "229f") Die Autoren beziehen sich dabei auf die Low-Code-Plattform Oracle APEX.

Im hier untersuchten Experiment kommt dabei mit Microsoft 365 Copilot Chat eine generische chatbasierte GenAI zum Einsatz, das sich von der unmittelbar in den Editor integrierten GenAI, wie Now Assist for Code unterscheidet. Anstelle einer direkten Bearbeitung des Codes liefert es vollständige Lösungsvorschläge auf Basis dialogisch formulierter Anfragen, welche erst durch Kopieren aus dem Chat und Einfügen in den Editor übernommen werden. Zudem greift Copilot Chat, anders als das plattforminterne Now Assist for Code, nicht auf interne Instanz- oder Plattformdaten von ServiceNow zurück, sondern stützt sein Wissen primär auf öffentlich zugängliche Web- und Trainingsdaten.#cf(<denisebmsftOverviewMicrosoft365>) Das domänenspezifische ServiceNow-Wissen, über das das Modell verfügt, beschränkt sich folglich auf jene Inhalte, die öffentlich im Internet dokumentiert sind, etwa offizielle Entwicklerdokumentation oder Community-Beiträge. Instanzspezifische Konfigurationen sowie individuelle Skript- und Datenmodelle bleiben dem LLM hingegen unzugänglich. Diese Unterscheidungen sind für diese Arbeit insofern relevant, als sie sowohl die Interaktionsform mit der GenAI als auch den Grad ihrer domänenspezifischen Unterstützung im Rahmen des Experiments unmittelbar bestimmen.

Mit der zunehmenden Verbreitung dieser Werkzeuge stellt sich jedoch unmittelbar die Frage nach ihren tatsächlichen Auswirkungen auf Entwicklungseffizienz und Softwarequalität. Dieser Frage widmet sich der folgende Abschnitt, der zunächst die methodischen Grundlagen der Effizienz- und Qualitätsmessung erarbeitet, bevor darauf aufbauend die Forschungshypothesen dieser Arbeit abgeleitet werden.

== Effizienz- und Qualitätsmessung in der Softwareentwicklung

=== Grundlagen der Softwarequalitätsmessung nach ISO/IEC 25010 <iso25010>

Um die Auswirkungen von GenAI auf die Qualität des entwickelten Codes zu untersuchen, ist zunächst eine Definition von Softwarequalität erforderlich. Nur wenn die Qualität definiert und messbar gemacht wird, ist es möglich eine bessere Softwarequalität überhaupt anzustreben. Das grundlegende Problem der Qualitätsmessung ist dabei, dass Qualität keine allgemeingültige, objektive Größe ist, sondern ein multidimensionales Konzept welches viele verschiedene Aspekte umfasst.#cf(<kanSoftwareQualityOverview1994a>, page: 5) Die Anfänge der Softwarequalitätsmessung lassen sich bin in die 1960er Jahre zurückverfolgen. So schrieben bereits 1968 Rubey und Hartwick in ihrem Beitrag darüber, wie Softwarequalität quantitativ messbar gemacht werden kann und welche Metriken dafür herangezogen werden können.#cf(<rubeyQuantitativeMeasurementProgram1968>, page: "672ff")

Aus diesen frühen Arbeiten hat sich bis heute der grundlegende Ansatz erhalten, Softwarequalität nicht direkt als eigene Größe zu messen, sondern über hierarchisch gegliederte Modelle zu operationalisieren. Übergeordnete Qualitätsmerkmale werden dabei in konkrete erhebbare Metriken überführt, wobei international anerkannte Standards den strukturellen Rahmen dafür abbilden. Als etablierter Standard hat sich hierbei die Normenreihe ISO/IEC 25000 unter dem Namen _#abbr("SQuaRE", "Systems and Software Quality Requirements and Evaluation")_ herausgebildet. Innerhalb dieser Normenreihe definiert die ISO/IEC 25010 ein Qualitätsmodell, das die Softwarequalität in neun übergeordnete Merkmale unterteilt, die wiederum in feinere Teilmerkmale aufgegliedert sind.#cf(<IsoStdIsoiec>)

Die neun Merkmale umfassen Functional Suitability, Performance Efficiency,
Compatibility, Interaction Capability, Reliability, Security, Maintainability,
Flexibility und Safety.#cf(<IsoStdIsoiec>) Die Norm legt damit ausschließlich
fest, _welche_ Eigenschaften Softwarequalität konstituieren, trifft jedoch
keine Aussage darüber, wie diese Eigenschaften im Einzelfall zu gewichten oder
zu erheben sind. Diese Entscheidung obliegt der jeweiligen Untersuchung und muss
sich am Untersuchungsgegenstand orientieren.

Diese Merkmale sind jedoch für sich genommen nicht direkt messbar, sondern werden in
der Norm weiter in Teilmerkmale untergliedert, die jeweils einen spezifischen
Aspekt des übergeordneten Merkmals konkretisieren. So gliedert sich
beispielsweise Functional Suitability in Functional Completeness, Functional
Correctness und Functional Appropriateness, während sich Maintainability unter
anderem in Analysability, Modifiability und Modularity aufteilt.#cf(<IsoStdIsoiec>) Eine vollständige Übersicht über die Merkmale und Teilmerkmale ist in @fig-ISO-IEC-25010 dargestellt.

#figure(
  image("../assets/ISO_IEC_25010.png"),
  caption: [Übersicht über die Qualitätsmodell Merkmale nach ISO/IEC 25010:2023#footnote[#fig-source(<UpdateISO250102026>)]]
) <fig-ISO-IEC-25010>

Erst auf dieser feineren Ebene lassen sich Messgrößen definieren, mit denen ein
Teilmerkmal quantitativ oder qualitativ erfasst werden kann. Normen wie
ISO/IEC 25010 liefern zwar die theoretischen Definitionen der Merkmale und
Teilmerkmale, tragen jedoch wenig zu deren praktischer Umsetzung bei und die
beschriebene Theorie muss erst operationalisiert
werden.#cf(<wagnerOperationalisedProductQuality2015>, page: "101f") 



=== Konzepte der Produktivitätsmessung und der Goal-Question-Metric-Ansatz <gqm>


=== Synthese und Ableitung der Forschungshypothesen