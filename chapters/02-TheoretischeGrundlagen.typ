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

Um die Auswirkungen von GenAI auf die Qualität des entwickelten Codes zu untersuchen, ist zunächst eine Definition von Softwarequalität erforderlich. Nur eine definierte und messbare Qualität lässt sich gezielt verbessern. Das grundlegende Problem der Qualitätsmessung ist dabei, dass Qualität keine allgemeingültige, objektive Größe ist, sondern ein multidimensionales Konzept welches viele verschiedene Aspekte umfasst.#cf(<kanSoftwareQualityOverview1994a>, page: 5) Die Anfänge der Softwarequalitätsmessung lassen sich bis in die 1960er Jahre zurückverfolgen. So schrieben bereits 1968 Rubey und Hartwick in ihrem Beitrag darüber, wie Softwarequalität quantitativ messbar gemacht werden kann und welche Metriken dafür herangezogen werden können.#cf(<rubeyQuantitativeMeasurementProgram1968>, page: "672ff")

Qualitätsmanagement und -messung stammen dabei aus der industriellen Fertigung, um die Qualität hergestellter Produkte zu sichern und zu verbessern. So wird Qualität als die Einhaltung von Anforderungen und Spezifikationen verstanden, die ein Produkt erfüllen muss, um den Erwartungen der Kunden zu entsprechen. In der Softwareentwicklung ist dies jedoch nicht so einfach möglich, da Softwareprodukte in der Regel nicht physisch greifbar sind. In analogen Systemen können Toleranzen definiert und gemessen werden, was in der Softwareentwicklung schlichtweg nicht möglich ist.#cf(<sommervilleSoftwareEngineering2016>, page: 703)

Dass Softwarequalität ein teilweise sehr subjektives Konstrukt ist, zeigt sich außerdem daran, dass einige Aspekte wie die Wartbarkeit oder die Verständlichkeit von Quellcode nicht direkt gemessen werden können. Des Weiteren haben diverse Stakeholder unterschiedliche Vorstellungen von ein und dem selben Softwareprodukt, was zu Kompromissen und somit Abweichungen von den ursprünglichen Anforderungen führen kann.#cf(<sommervilleSoftwareEngineering2016>, page: "703ff")

Eine vollumfassende Definition für gute Softwarequalität zu finden ist daher nicht möglich. Erkennbar ist dies auch an der von der #abbr("ISO", "International Organization for Standardization") und #abbr("IEC", "International Electrotechnical Commission") entwickelten Norm ISO/IEC 25010, die Softwareproduktqualität in neun übergeordnete Merkmale unterteilt, die wiederum in feinere Teilmerkmale aufgegliedert sind, wie in @fig-ISO-IEC-25010 zu erkennen ist. Jedes Merkmal definiert dabei einen spezifischen Aspekt von Softwarequalität. So stellt die Functional Suitability, zu deutsch 
Funktionale Eignung, die Fähigkeit der Software dar, die expliziten und impliziten Anforderungen der Nutzer unter bestimmten Bedingungen zu erfüllen.#cf(<IsoStdIsoiec>) Die Maintainability, zu deutsch Wartbarkeit, beschreibt wiederum die Fähigkeit der Software von den entsprechenden Personen effektiv und effizient modifiziert werden zu können.#cf(<IsoStdIsoiec>)

#figure(
  image("../assets/ISO_IEC_25010.png"),
  caption: [Übersicht über die Qualitätsmodell Merkmale nach ISO/IEC 25010:2023#footnote[#fig-source(<UpdateISO250102026>)]]
) <fig-ISO-IEC-25010>

Auch wenn die Norm auf diese Weise festlegt, welche Merkmale und Teilmerkmale Softwarequalität konstituieren, bleibt offen, wie diese in der Praxis tatsächlich gemessen werden können. Die in ISO/IEC 25010 beschriebenen Teilmerkmale sind selbst noch zu abstrakt, um unmittelbar erhoben zu werden, und müssen daher erst operationalisiert werden, bevor sich Qualität überhaupt quantifizieren lässt.#cf(<wagnerOperationalisedProductQuality2015>, page: "101f")

Am Beispiel des Quamoco-Ansatzes lässt sich diese Operationalisierung konkret darstellen. Wagner et al. unterscheiden dabei zwischen den abstrakten Qualitätsaspekten, die sich stets auf das gesamte Produkt beziehen und nicht direkt messbar sind, und sogenannten Produktfaktoren, die konkrete, beobachtbare Eigenschaften einzelner Produktbestandteile beschreiben und dadurch messbar sind.#cf(<wagnerOperationalisedProductQuality2015>, page: "104f") So lässt sich etwa das Merkmal Maintainability nicht unmittelbar erfassen, jedoch der ihm zugeordnete Produktfaktor Duplizierung von Code-Abschnitten, der sich über die Messgröße der Klon-Abdeckung quantifizieren lässt.#cf(<wagnerOperationalisedProductQuality2015>, page: "104") Jeder Messgröße wird darüber hinaus ein konkretes Instrument zugeordnet, das die tatsächliche Datenerhebung realisiert, etwa eine Regel eines Codeanalysewerkzeugs.#cf(<wagnerOperationalisedProductQuality2015>, page: "105") Softwarequalitätsmessung erfolgt somit stets mehrstufig. Erst die schrittweise Zerlegung abstrakter Merkmale in konkrete, beobachtbare Eigenschaften und deren Zuordnung zu Messgrößen und Erhebungsinstrumenten macht eine quantitative Erfassung von Softwarequalität überhaupt möglich.


=== Konzepte der Effizienzmessung und der Goal-Question-Metric-Ansatz <gqm>

Während sich die Messung von Softwarequalität in @iso25010 auf eine etablierte Norm stützt, existiert für die Messung von Effizienz bzw. Produktivität in der Softwareentwicklung kein vergleichbar Standard.

Effizienz wird in der Softwareentwicklung üblicherweise im Zusammenhang mit den verwandten Begriffen Produktivität und Effektivität diskutiert, die in der Literatur häufig unscharf voneinander abgegrenzt werden.#cf(<wagnerDefiningProductivitySoftware2019>, page: "29f") Zunächst ist die Effektivität von der Produktivität und Effizienz abzugrenzen. Effektivität ist demnach ein "Beurteilungskriterium, mit dem sich beschreiben lässt, ob eine Maßnahme geeignet ist, ein vorgegebenes Ziel zu erreichen".#quot(<thommenDefinitionEffektivitaet>) 

Produktivität bezeichnet hingegen grundsätzlich das Verhältnis aus einem generierten Output zu dem dafür aufgebrachten Aufwand. Die tatsächlichen Maße und Einheiten für Output und Input sind jedoch nicht branchenübergreifend einheitlich. Produktivität lässt sich zwar bei manueller Handarbeit recht einfach nachvollziehen, bei anderen Arten von Arbeit, wie bspw. Wissensarbeiten ist dies jedoch nur sehr schwer vergleichbar. Wissensarbeit ist in diesem Kontext jegliche Art von Arbeit, bei der die Arbeitskräfte ihr theoretisches und analytisches Wissen anwenden, um neue Produkte bzw. Dienstleistungen zu erschaffen.#cf(<ramirezMeasuringKnowledgeWorker>, page: 604)

Der Begriff der Effizienz betrachtet im Rahmen der Produktivität vor allem die Seite des eingesetzten Aufwands.#cf(<wagnerDefiningProductivitySoftware2019>, page: 33) Da im Rahmen des Experiments dieser Arbeit der zu erzeugende Output bereits festgelegt ist, ist es vor allem die Effizienz, die in dieser Studie neben den Qualitätsaspekten untersucht wird.

Ein Effizienzverständnis, welches allerdings ausschließlich den Aufwandsaspekt begutachtet, läuft dabei Gefahr ausschließlich einfache Metriken wie die geschriebenen #abbr("LOC", "Lines of Code", german: "Quellcode") zu betrachten. Solche Maße sind jedoch nicht wirklich aussagekräftig, da sie bloße Aktivität mit tatsächlich nutzbarem Output verwechseln und weder die Qualität des Ergebnisses, noch tatsächlich gelösten Anteil einer Aufgabe berücksichtigen.#cf(<forsgrenSPACEDeveloperProductivity2021>, page: 52) Ein Entwickler, der viele LOC produziert, dabei allerdings überproportional viel Nacharbeit verursacht, ist grundlegend nicht automatisch effizienter als ein Entwickler, dessen Code mit geringerem Umfang ein stabileres Ergebnis liefert. Effizienzmessung in der Softwareentwicklung sollte folglich neben dem reinen Zeit- bzw. Aufwandsaspekt auch den Prozessverlauf bis zum fertigen und akzeptierten Ergebnis einbeziehen.#cf(<forsgrenSPACEDeveloperProductivity2021>, page: 52)

Einen  Rahmen zur Einordnung von Entwicklerproduktivität liefert das SPACE-Rahmenwerk von Forsgren et al. aus dem Jahr 2021, das fünf Dimensionen unterscheidet: Satisfaction and Well-Being, Performance, Activity, Communication und Collaboration sowie Efficiency und Flow.#cf(<forsgrenSPACEDeveloperProductivity2021>, page: "48ff") Für diese Bachelor-Thesis ist insbesondere die Dimension Efficiency und Flow relevant, die den ungestörten, zügigen Fortschritt eines Entwicklers bei der Aufgabenbearbeitung beschreibt. Die übrigen Dimensionen liegen außerhalb des Untersuchungsgegenstands dieser Thesis, da das Experimentdesign auf Einzelaufgaben ohne Teaminteraktion ausgelegt ist. Das SPACE-Rahmenwerk bestätigt die grundlegende Annahme, dass Produktivität und damit auch die ihr zugrundeliegende Effizienzdimension kein eindimensionales Konstrukt ist, sondern erst durch eine Kombination mehrerer, aufeinander bezogener Messgrößen abgebildet werden kann.#cf(<forsgrenSPACEDeveloperProductivity2021>, page: 46)

Um aus diesem theoretischen Effizienzverständnis konkrete, im Experiment erhebbare Metriken abzuleiten, wird im Folgenden der #abbr("GQM", "Goal-Question-Metric")-Ansatz nach Basili und Rombach herangezogen.#cf(<basiliGoalQuestionMetric1994>, page: "528ff") GQM verfolgt grundsätzlich eine Top-Down-Logik. Dabei werden ausgehend von einem übergeordneten konzeptionellen Messziel (Goal) Fragen (Questions) formuliert, die das zuvor definierte Ziel characterisieren. Im dritten Schritt werden diesen Fragen konkrete, quantifizierbare Messgrößen (Metrics) zugeordnet. Die Messgrößen können dabei sowohl objektiv, als auch subjektiv sein.#cf(<basiliGoalQuestionMetric1994>, page: "528f")

Ein GQM-Modell ist dabei wie in @gqm-hierarchie zu sehen hierarchisch aufgebaut. Ein Ziel wird zu mehreren Fragen verfeinert, denen wiederum jeweils eine oder mehrere Metriken zugeordnet werden. Einzelne Metriken können dabei auch mehrfach zur Beantwortung unterschiedlicher Questions herangezogen werden.#cf(<basiliGoalQuestionMetric1994>, page: "529")

#figure(
  image("../assets/gqm_hierarchie.png"),
  caption: [GQM-Hierarchie#footnote[#fig-based-on(<basiliGoalQuestionMetric1994>, page: 529)]]
) <gqm-hierarchie>

Die Definition eines Goals erfolgt anhand von vier Koordinaten. Zum einen dem Zweck, englisch Purpose, zum anderen dem zu untersuchenden Qualitätsmerkmal (Issue), dem Messobjekt (Object) sowie der Betrachtungsperspektive (Viewpoint), aus der die Messung erfolgt.#cf(<basiliGoalQuestionMetric1994>, page: "529f")

Die nachfolgende Tabelle stellt die Anwendung des GQM-Ansatzes in Bezug auf das im Rahmen dieser Thesis durchgeführte Experiment dar.

#figure(
  table(
    columns: (auto, auto, 1fr),
    align: (left, left, left),
    table.hline(),
    [*Goal*], text(weight: "regular")[Purpose], text(weight: "regular")[Untersuchen],
    [], [Issue], [der Wirkung von GenAI-Unterstützung auf],
    [], [Object (process)], [die Code-Generierung bei ServiceNow Business Rules],
    [], [Viewpoint], [aus Sicht des ServiceNow-Entwicklers / IT-Dienstleisters],
    table.hline(),

    [*Question*], [Q1], [Wie verändert sich der Zeitbedarf bis zur bestandenen Testsuite durch GenAI-Unterstützung?],
    [*Metrics*], [M1], [Time-to-first-draft],
    [], [M2], [Time-to-first-pass],
    table.hline(),

    [*Question*], [Q2], [Wie verändert sich der Iterations- und Nacharbeitsaufwand?],
    [*Metrics*], [M3], [Iterationszyklen],
    [], [M4], [Rework-Rate],
    [], [M5], [Debugging-Zeit],
    table.hline(),

    [*Question*], [Q3], [Wie verändert sich die funktionale Korrektheit der generierten Artefakte?],
    [*Metrics*], [M6], [ATF-Pass-Rate],
    [], [M7], [First-Time-Right-Quote],
    table.hline(),

    [*Question*], [Q4], [Wie verändert sich die Wartbarkeit der generierten Artefakte?],
    [*Metrics*], [M8], [ISO-25010-Rubrik-Score (Modularity, Analysability, Modifiability)],
    [], [M9], [Codelänge (LOC, SLOC-Konvention)],
    [], [M10], [Kommentierungsgrad],
    table.hline(),

    [*Question*], [Q5], [Wie unterscheiden sich die Effekte aus Q1–Q4 zwischen Erfahrungsniveaus (Junior/Senior)?],
    [*Metrics*], [M11], [Subgruppenvergleich je Metrik (M1–M10) nach Erfahrungsgruppe],
    [], [M12], [Interaktionseffekt Erfahrung × Bedingung],
    table.hline(),
  ),
  caption: [GQM-Modell dieser Arbeit, in Anlehnung an das Vorgehen von Basili und Rombach #cf(<basiliGoalQuestionMetric1994>, page: "528ff")],
) <tab-gqm>

=== Synthese und Ableitung der Forschungshypothesen

