#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi
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

Die Wirtschaftsinformatik betrachtet Informationstechnologie nicht ausschließlich als technisches Artefakt, sondern als Investitionsgegenstand, dessen Beitrag zur betrieblichen Wertschöpfung zu beurteilen ist. Für die Bewertung eines Entwicklungswerkzeugs sind dabei zwei Dimensionen zu unterscheiden: Die Effizienz beschreibt das Verhältnis von eingesetzten Ressourcen zum erzeugten Ergebnis und ist unmittelbar kostenwirksam, während die Qualität die Beschaffenheit des Ergebnisses selbst betrifft und ökonomisch zeitversetzt wirkt. Mängel in der Wartbarkeit oder funktionale Fehler verursachen Aufwände, die nicht im Entwicklungs-, sondern im Betriebs- und Wartungsbudget anfallen, auf das über den Lebenszyklus hinweg der überwiegende Teil der Gesamtkosten entfällt.QUELLE Eine isolierte Betrachtung der Entwicklungszeit wäre daher irreführend, da eine verkürzte Bearbeitungsdauer bei gesunkener Qualität keine Produktivitätssteigerung darstellt, sondern lediglich eine Verlagerung von Aufwand in spätere Phasen. Beide Dimensionen müssen folglich gemeinsam erhoben werden; die Qualitätsdimension wird nachfolgend fundiert.

Für Implementierungsprojekte auf Plattformen wie ServiceNow gilt dieser Zusammenhang in besonderem Maße, da einmal erstellte Skriptartefakte über zahlreiche Release-Zyklen hinweg fortbestehen und von wechselnden Entwicklern gepflegt werden. Voraussetzung für eine belastbare Bewertung ist allerdings ein präziser und intersubjektiv nachvollziehbarer Qualitätsbegriff. Da Softwarequalität ein mehrdimensionales Konstrukt aus teils gegenläufigen Eigenschaften darstellt, würde eine Verkürzung auf einzelne Indikatoren wie Fehlerfreiheit oder Codelänge die Vergleichbarkeit der im Experiment erhobenen Artefakte gefährden. Als international etablierter Bezugsrahmen dient die Normenreihe ISO/IEC 25000 (#abbr("SQuaRE", "Systems and Software Quality Requirements and Evaluation")), innerhalb derer ISO/IEC 25010 das Modell der Produktqualität definiert.QUELLE

Das Produktqualitätsmodell gliedert Softwarequalität hierarchisch in neun Qualitätsmerkmale, die sich ihrerseits in Teilmerkmale untergliedern: Functional Suitability, Performance Efficiency, Compatibility, Interaction Capability, Reliability, Security, Maintainability, Flexibility und Safety. Die Norm beschreibt damit ausschließlich, _welche_ Eigenschaften Qualität konstituieren; konkrete Messvorschriften und Kennzahlen sind nicht Gegenstand von ISO/IEC 25010, sondern werden in ISO/IEC 25023 gesondert behandelt.QUELLE Das Modell liefert somit die Struktur der Qualitätsbetrachtung, nicht jedoch deren Operationalisierung. Abzugrenzen ist es zudem von der Quality in Use, die seit der Revision der Normenreihe in ISO/IEC 25019 eigenständig geführt wird und die Qualität aus Sicht des Endanwenders in einem konkreten Nutzungskontext beschreibt. Da im Experiment serverseitige Skriptartefakte ohne Endanwenderinteraktion entstehen und keine produktive Nutzung stattfindet, beschränkt sich die Bewertung dieser Arbeit ausschließlich auf die Produktqualität.

Die vollständige Erhebung aller neun Merkmale ist im Rahmen eines zeitlich begrenzten Experiments mit eng umrissenen Entwicklungsaufgaben weder möglich noch sinnvoll. Eine Messung von Merkmalen, die durch den gewählten Aufgabenzuschnitt gar nicht variiert werden können, würde lediglich Scheingenauigkeit erzeugen. Die Auswahl der betrachteten Merkmale erfolgt daher bewusst und wird in @tab-iso-auswahl offengelegt.

#figure(
  table(
    columns: (auto, auto, 1fr),
    align: (left, center, left),
    table.header([*Qualitätsmerkmal*], [*Betrachtet*], [*Begründung*]),
    [Functional Suitability], [ja],
    [Kernkriterium: Erfüllt der generierte Code die fachlichen Anforderungen? Über die ATF-Suites objektiv prüfbar.],
    [Reliability], [ja],
    [Robustheit gegenüber unvollständigen Datenkonstellationen (z. B. fehlende Referenzen) ist im Aufgabenzuschnitt angelegt und prüfbar.],
    [Maintainability], [ja],
    [Zentrales Qualitätsrisiko generierter Artefakte und für Implementierungsprojekte langfristig kostenrelevant.],
    [Performance Efficiency], [nein],
    [Laufzeitmessungen auf einer geteilten Instanz mit geringem Datenvolumen wären konfundiert; performanzkritische Muster werden stattdessen im Rahmen der Wartbarkeitsbewertung erfasst.],
    [Security], [nein],
    [Erforderte sicherheitsrelevante Aufgabenstellungen (z. B. Zugriffskontrolle); im gewählten Zuschnitt nicht variierbar.],
    [Compatibility], [nein],
    [Keine Schnittstellen zu externen Systemen im Aufgabenumfang.],
    [Interaction Capability], [nein],
    [Business Rules sind serverseitige Artefakte ohne Benutzeroberfläche.],
    [Flexibility], [nein],
    [Setzt Betrachtung über mehrere Umgebungen oder Releases hinweg voraus; im Momentaufnahmecharakter des Experiments nicht erhebbar.],
    [Safety], [nein],
    [Kein sicherheitskritischer Anwendungskontext im Sinne der Norm.],
  ),
  caption: [Auswahl der betrachteten Qualitätsmerkmale nach ISO/IEC 25010],
) <tab-iso-auswahl>

Innerhalb der drei ausgewählten Merkmale ist eine weitere Präzisierung auf Ebene der Teilmerkmale erforderlich, da erst diese eine Operationalisierung erlauben. Für die *Functional Suitability* sind Functional Completeness und Functional Correctness maßgeblich: Ersteres erfasst, ob sämtliche in der Aufgabenstellung formulierten Anforderungen umgesetzt wurden, Letzteres, ob die umgesetzte Logik die fachlich korrekten Ergebnisse liefert. Beide Teilmerkmale werden durch die Testfälle der ATF-Suites abgedeckt. Bei der *Reliability* steht die Fehlertoleranz im Vordergrund, also das Verhalten des Skripts bei unvollständigen oder unerwarteten Datenkonstellationen. Für die *Maintainability* werden Analysability, Modifiability und Modularity herangezogen, die sich in Struktur, Benennung, Kommentierung und der Verwendung plattformkonformer Muster niederschlagen und im Gegensatz zu den beiden erstgenannten Merkmalen nicht automatisiert, sondern anhand einer Bewertungsrubrik erhoben werden.QUELLE

Diese Fokussierung korrespondiert mit der in @genAiSoftwareentwicklung dargestellten Befundlage: Gerade dort, wo generierter Code syntaktisch plausibel wirkt, aber fachlich abweicht oder schwer nachvollziehbare Strukturen aufweist, liegen die berichteten Qualitätsrisiken.QUELLE Damit ist die qualitätsbezogene Hälfte des Messinstrumentariums abgesteckt. Da ISO/IEC 25010 weder Aussagen zur Entwicklungseffizienz trifft noch selbst Messvorschriften bereitstellt, bedarf es ergänzend eines Verfahrens, das sowohl Qualitäts- als auch Effizienzziele systematisch in erhebbare Metriken überführt.

=== Konzepte der Produktivitätsmessung und der Goal-Question-Metric-Ansatz <gqm>

Produktivität ist betriebswirtschaftlich als Verhältnis von Output zu Input definiert. Während sich der Input in Entwicklungsprojekten mit der aufgewendeten Arbeitszeit vergleichsweise unproblematisch erfassen lässt, entzieht sich der Output einer eindeutigen Bestimmung. Der lange Zeit verbreitete Rückgriff auf die Anzahl der Codezeilen (#abbr("LOC", "Lines of Code")) gilt heute als methodisch unhaltbar, da die Kennzahl den erzeugten Nutzen nicht abbildet, sondern lediglich den Umfang des Artefakts: Eine kompakte, gut strukturierte Lösung erschiene gegenüber einer redundanten als weniger produktiv, obwohl sie das überlegene Ergebnis darstellt.QUELLE Im Kontext generativer KI verschärft sich dieses Problem zusätzlich, da Sprachmodelle systematisch umfangreicheren Code erzeugen und eine umfangsbasierte Messung den Effekt der Werkzeugunterstützung folglich systematisch überschätzen würde.

Neuere Ansätze begegnen dieser Problematik, indem sie Produktivität explizit als mehrdimensionales Konstrukt auffassen. Das SPACE-Framework unterscheidet hierzu fünf Dimensionen — Satisfaction, Performance, Activity, Communication und Efficiency — und formuliert die Anforderung, Produktivität niemals über eine einzelne Kennzahl, sondern stets über Metriken aus mehreren Dimensionen zu erfassen.QUELLE Für die vorliegende Arbeit ist dieses Rahmenwerk insofern relevant, als es die Beschränkung auf reine Zeitmessung ausschließt. Zugleich sind nicht alle Dimensionen im Rahmen eines kontrollierten Experiments mit kurzer Bearbeitungsdauer erhebbar: Kommunikation entfällt bei Einzelbearbeitung vollständig, und Zufriedenheit ließe sich allenfalls über eine ergänzende Befragung erfassen. Die Untersuchung konzentriert sich daher auf die ergebnis- und ablaufbezogenen Dimensionen Performance, Activity und Efficiency, die sich über die Instrumentierung der Entwicklungsumgebung objektiv protokollieren lassen.

Aus beiden Befunden folgt, dass Produktivität nicht allgemeingültig, sondern nur bezogen auf ein konkretes Erhebungsziel messbar ist. Erforderlich ist somit ein Verfahren, das von diesem Ziel ausgehend nachvollziehbar zu geeigneten Metriken führt, anstatt verfügbare Kennzahlen nachträglich zu interpretieren. Diese Leistung erbringt der Goal-Question-Metric-Ansatz nach Basili und Rombach. Er strukturiert die Messplanung top-down über drei Ebenen: Auf der konzeptionellen Ebene wird ein Goal formuliert, das Untersuchungsgegenstand, Zweck, Qualitätsfokus, Betrachtungsperspektive und Kontext festlegt. Auf der operationalen Ebene wird dieses Ziel in Questions zerlegt, die beschreiben, welche Teilaspekte zur Zielerreichung beantwortet werden müssen. Auf der quantitativen Ebene wird schließlich jeder Frage mindestens eine Metric zugeordnet, die eine datenbasierte Antwort ermöglicht.QUELLE Der wesentliche methodische Vorteil liegt in der Rückverfolgbarkeit: Jede erhobene Kennzahl lässt sich einer Frage und damit dem übergeordneten Ziel zuordnen, wodurch sowohl die Erhebung nicht verwertbarer Daten als auch die nachträgliche Interpretation zufällig verfügbarer Messwerte vermieden wird.

Angewandt auf den Untersuchungsgegenstand dieser Arbeit lautet das Goal, den Einsatz generativer KI zum Zweck der Bewertung hinsichtlich Entwicklungseffizienz und Codequalität aus der Perspektive von Entwicklern und IT-Dienstleistern im Kontext der Code-Generierung in ServiceNow-Implementierungen zu analysieren. Die daraus abgeleiteten Fragen und Metriken sind in @tab-gqm dargestellt.

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    table.header([*Nr.*], [*Question*], [*Metrics*]),
    [Q1],
    [Wie verändert sich der Zeitbedarf bis zur funktionsfähigen Lösung?],
    [Time-to-first-draft; Time-to-first-pass],
    [Q2],
    [Wie verändert sich der Iterations- und Nacharbeitsaufwand?],
    [Iterationszyklen; Rework-Rate; Debugging-Zeit],
    [Q3],
    [Wie verändert sich die funktionale Korrektheit des Ergebnisses?],
    [ATF-Pass-Rate; First-Time-Right-Quote],
    [Q4],
    [Wie verändert sich die Wartbarkeit des erzeugten Codes?],
    [Bewertungsrubrik zu Analysability, Modifiability und Modularity],
  ),
  caption: [Goal-Question-Metric-Ableitung für die vorliegende Untersuchung],
) <tab-gqm>

Die Fragen Q1 und Q2 bilden die Effizienzdimension ab und unterscheiden dabei bewusst zwischen der reinen Bearbeitungsdauer und dem Aufwand, der zur Korrektur einer zunächst unzureichenden Lösung erforderlich ist. Diese Trennung ist erforderlich, weil generative KI einen schnellen ersten Entwurf ermöglichen kann, dessen Fehler den anfänglichen Zeitgewinn in der Nacharbeit wieder aufzehren. Q3 und Q4 überführen die in ausgewählten Qualitätsmerkmale in Fragestellungen, wobei Q3 die Teilmerkmale der Functional Suitability sowie die Fehlertoleranz adressiert und Q4 die Wartbarkeit. Ergänzend verbindet die qualitätsadjustierte Effizienz beide Dimensionen, indem sie den Zeitaufwand auf die tatsächlich erreichte funktionale Vollständigkeit bezieht und damit verhindert, dass eine schnelle, aber unvollständige Bearbeitung als Effizienzgewinn ausgewiesen wird.

Die formale Definition der Metriken einschließlich ihrer Berechnungsvorschriften, Datenquellen und Skalenniveaus erfolgt im Rahmen des Forschungsdesigns in AT 3.3. An dieser Stelle ist zunächst festzuhalten, dass mit ISO/IEC 25010 und dem Goal-Question-Metric-Ansatz beide Dimensionen der Untersuchung — Qualität und Effizienz — in einem konsistenten Messrahmen erfasst sind. Auf dieser Grundlage lassen sich die Erwartungen an die Wirkung generativer KI theoriegeleitet präzisieren und in prüfbare Hypothesen überführen.

=== Synthese und Ableitung der Forschungshypothesen