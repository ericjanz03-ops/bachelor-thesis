#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi
#import "../lib/abbr.typ": abbr

= Theoretische Grundlagen <theoretischeGrundlagen>

== Architektur und Entwicklung in ServiceNow-Modulen


== Generative KI in der Softwareentwicklung

Um die in dieser Arbeit untersuchten Effizienz- und Qualitätseffekte einordnen zu können, ist zunächst ein grundlegendes Verständnis der zugrunde liegenden Technologie erforderlich. Unter #abbr("KI", "Künstliche Intelligenz") wird im Allgemeinen die Fähigkeit von Systemen verstanden, Aufgaben zu bewältigen, die traditionell menschliche Intelligenz erfordern.#cf(<russellArtificialIntelligenceModern2016>, page: "1f") 

Eine bedeutende Teilmenge davon stellt #abbr("GenAI", "Generative Artificial Intelligence") dar, die in der Lage ist, eigenständig neue Inhalte wie Text, Bilder oder eben Quellcode zu erzeugen, anstatt lediglich bestehende Daten zu klassifizieren oder auszuwerten. Um dies zu ermöglichen werden bereits bestehende klassifizierte Daten analysiert und auf Basis dieser Informationen neue Inhalte generiert.#cf(<euchnerGenerativeAI2023>, page: 71) In der Softwareentwicklung wird diese Fähigkeit vor allem durch die Nutzung von #abbr("LLM", "Large Language Models") unter anderem zur Code-Generierung aus natürlicher Sprache genutzt. Dieser Prozess wird als Natural-Language-to-Code bezeichnet und ist Gegenstand der hier vorliegenden Arbeit.#cf(<jiangSurveyLargeLanguage2026>, page: 2)

LLMs sind dabei eine spezifische Art eines KI-Algorithmus, die in der Lage sind vielfältige Aufgaben aus dem Bereich des #abbr("NLP", "Natural Language Processing") zu bewältigen. Zu diesen Aufgaben zählen unter anderem Textgenerierung, Übersetzung und das Beantworten von Fragen.#cf(<raiaanReviewLargeLanguage2024>, page: "26846f") 

Der Verarbeitungsprozess einer natürlichsprachlichen Eingabe beginnt damit, dass der Text in kleinere Einheiten, sogenannte Tokens, zerlegt wird.#cf(<websterTokenizationInitialPhase1992>, page: 1106) Das Modell verarbeitet diese anschließend als numerische Vektoren, um die die semantische Bedeutung der Tokens zu erfassen.#cf(<raiaanReviewLargeLanguage2024>, page: "26848")

Das zentrale Element moderner LLMs bildet dabei die Transformer-Architektur mit einem Self-Attention-Mechanismus, der es dem Modell ermöglicht, die Beziehungen zwischen allen Tokens einer Eingabesequenz gleichzeitig zu erfassen.#cf(<raiaanReviewLargeLanguage2024>, page: "26849f") Auf dieser Grundlage sagt das Modell bei der eigentlichen Textgenerierung fortlaufend das jeweils wahrscheinlichste nächste Token voraus, bis eine vollständige Ausgabesequenz entstanden ist.#cf(<raiaanReviewLargeLanguage2024>, page: "26849f") Da an jeder Stelle stets die statistisch wahrscheinlichste Fortsetzung gewählt wird, folgt daraus eine grundlegende Eigenschaft moderner Codegenerierung: Das LLM erzeugt denjenigen Code, der dem gelernten Muster am ehesten entspricht, ohne dessen funktionale Korrektheit zu garantieren.

In der praktischen Anwendung deckt GenAI-gestützte Codegenerierung heute ein breites Spektrum an Aufgaben im Softwareentwicklungsprozess ab. Neben der reinen Code-Vervollständigung – dem historisch ersten und bekanntesten Anwendungsfall – zählen dazu insbesondere die automatisierte Generierung von Testfällen, die Unterstützung bei der Fehlersuche und -behebung (Debugging), die Erstellung technischer Dokumentation sowie Vorschläge zur Refaktorisierung bestehenden Codes. Ebert und Louridas ordnen diese Funktionen als festen Bestandteil moderner Entwicklungswerkzeuge ein und verweisen auf die zunehmende Integration solcher Assistenzsysteme, etwa in Form von GitHub Copilot, direkt in gängige Entwicklungsumgebungen. QUELLE

Der zentrale Reiz dieser Technologie liegt in ihrem Effizienzversprechen. So weisen Peng et al. in einer kontrollierten Studie mit GitHub Copilot eine Reduktion der Bearbeitungszeit von bis zu 55,8 % gegenüber der Programmierung ohne KI-Unterstützung nach.#cf(<pengImpactAIDeveloper2023>, page: "5f") Neben der reinen Zeitersparnis werden GenAI-Werkzeugen weitere Potenziale zugeschrieben, etwa eine geringere Einstiegshürde für weniger erfahrene Entwickler sowie eine Entlastung von repetitiven Programmieraufgaben, wodurch mehr Kapazität für konzeptionelle Entscheidungen entsteht.

Diesen Potenzialen stehen jedoch erhebliche Herausforderungen gegenüber, die unmittelbar aus der stochastischen Funktionsweise der Modelle resultieren. Da LLMs plausiblen, nicht zwingend korrekten Code erzeugen, besteht das Risiko sogenannter Halluzinationen – syntaktisch einwandfreier, semantisch jedoch fehlerhafter Codeabschnitte. Ghorbian et al. betonen, dass diese Unschärfe die Softwarequalität in mehrfacher Hinsicht gefährden kann, etwa hinsichtlich Zuverlässigkeit, Wartbarkeit und Sicherheit.#cf(<ghorbianLargeLanguageModels2026>, page: "9f") Empirisch untermauert wird dies durch Tosi, der in einer vergleichenden Untersuchung unterschiedlicher GenAI-Engines teils erhebliche Qualitätsunterschiede des generierten Codes feststellt.QUELLE Zhang et al. weisen zudem auf die Notwendigkeit hin, generierte Artefakte weiterhin durch menschliche Expertise zu validieren, um diese Qualitätsrisiken abzufedern.QUELLE Erste Befunde deuten außerdem darauf hin, dass sich Nutzen und Risiken je nach Erfahrungsniveau der Entwickler unterscheiden, da unerfahrene Entwickler ein höheres Risiko tragen, fehlerhafte Vorschläge unreflektiert zu übernehmen.QUELLE Dieser Aspekt wird im Rahmen von RQ3 gesondert aufgegriffen.

Besondere Relevanz erhält diese Gemengelage aus Effizienzgewinn und Qualitätsrisiko im Kontext von Low-Code-Plattformen. Wie Liu et al. zeigen, integrieren Anbieter wie ServiceNow generative KI zunehmend direkt in ihre Entwicklungsumgebungen, um auch die verbleibenden, skriptbasierten Anteile der Plattformentwicklung zu unterstützen.QUELLE Vergleichbare Entwicklungen lassen sich auch bei anderen Low-Code-Systemen beobachten: Paliwal et al. beschreiben den Einsatz von GenAI in Low-Code/No-Code-Umgebungen allgemein,QUELLE während Gorissen et al. am Beispiel von Oracle APEX empirisch untersuchen, wie LLM-Unterstützung die Entwicklung in einer strukturell mit ServiceNow vergleichbaren Plattform beeinflusst.QUELLE Diese Befunde verdeutlichen, dass die Verbindung von generativer KI und Low-Code-Entwicklung kein rein akademisches, sondern ein hochaktuelles praktisches Phänomen darstellt – und begründen damit den in dieser Arbeit gewählten Fokus auf ServiceNow als konkretes Untersuchungsfeld.

== Effizienz- und Qualitätsmessung in der Softwareentwicklung

=== Grundlagen der Softwarequalitätsmessung nach ISO/IEC 25010

=== Konzepte der Produktivitätsmessung und der Goal-Question-Metric-Ansatz

=== Synthese und Ableitung der Forschungshypothesen