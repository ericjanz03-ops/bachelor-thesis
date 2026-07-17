#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi
#import "../lib/abbr.typ": abbr

= Einleitung <einleitung>

== Motivation und Zielsetzung

Bereits 1971 wurde in der anfänglichen Forschung zur automatisierten Synthese von
Softwareprogrammen von Manna und Waldinger beschrieben, dass es oft einfacher ist,
das Ziel einer Berechnung abstrakt zu beschreiben, als den Programmcode dafür explizit zu definieren.#cf(<mannaAutomaticProgramSynthesis1971>, page: 151) Während diese Vision der automatisierten Code-Generierung historisch
durch starre, deterministische Ansätze und komplexe mathematische Theorembeweise
verfolgt wurde, ist sie heute durch brandaktuelle #abbr("LLM", "Large Language Models") geprägt.
Software kann somit direkt aus natürlicher Sprache generiert werden. So präsentieren
Jiang et al. in ihrer Studie aus dem Januar 2026 eine umfassende Übersicht über diesen
Paradigmenwechsel, den sie als Natural-Language-to-Code definieren.#cf(<jiangSurveyLargeLanguage2026>, page: 8) Gleichzeitig
betonen die Autoren jedoch eine Lücke zwischen der rein akademischen Forschung und
der praktischen Softwareentwicklung. Sie stellen fest, dass etablierte, standardisierte
Evaluierungs-Benchmarks die Komplexität und Herausforderungen von realen,
industriellen Entwicklungsszenarien nicht angemessen widerspiegeln.#cf(<jiangSurveyLargeLanguage2026>, page: 55)
Um diese Lücke zwischen akademischer Forschung und industrieller Praxis zu schließen,
fokussiert sich die hier geplante Arbeit auf ServiceNow-Projekte. Historisch war die
Bereitstellung von Unternehmenssoftware stark durch das fundamentale Dilemma
zwischen teurer Individualentwicklung und funktionaler, aber dafür starrer
Standardsoftware geprägt. Dies beschreibt Brooks in einem 1987 veröffentlichten
Fachartikel, in dem er schon damals die anfallenden Entwicklungskosten dem oftmals
günstigeren Kaufpreis für Standardsoftware gegenüberstellt.#cf(<brooksNoSilverBullet1987>, page: "16f") Brooks argumentiert stark
für die Verwendung von Standardsoftware aufgrund der oft guten Dokumentation, breiten
Verfügbarkeit und schnellen Entwicklung.#cf(<brooksNoSilverBullet1987>, page: "16f")  Die Relevanz dieses Fokus wird durch die
heutige Marktstellung der ServiceNow-Plattform verdeutlicht. Mit einem globalen
Kundenstamm von über 8100 Unternehmen und einer Durchdringung von mehr als 85 %
der Fortune-500-Unternehmen hat sich ServiceNow zu einem der wichtigsten
Standardsoftware-Lieferanten auf dem gesamten Markt etabliert.#cf(<servicenowinc.2026ProxyStatement2026>, page: 2) Folglich ist die
Implementierung von ServiceNow und somit die Softwareentwicklung bzw.
Softwarekonfiguration der Plattform, welche auf den Low-Code-Ansatz setzt, von großer
wirtschaftlicher Bedeutung.
Genau in diesem bedeutenden Umfeld der Softwareentwicklung verspricht der Einsatz
von #abbr("GenAI", "Generative Artificial Intelligence", german: "generative künstliche Intelligenz"), die Entwicklungseffizienz drastisch zu steigern. Die empirische Studie von
Peng et al. aus dem Jahr 2023 belegt dabei eine Ersparnis in der Entwicklungszeit von bis
zu 55,8 % unter Nutzung von GitHub Copilot.#cf(<pengImpactAIDeveloper2023>, page: "5f") Dieser enorme Effizienzgewinn geht
jedoch unweigerlich mit neuen, komplexen Herausforderungen für die Softwarequalität
einher. Im Gegensatz zu traditionellen, deterministischen und regelbasierten Methoden
arbeiten moderne LLMs bei der Code-Generierung rein stochastisch und datengetrieben.
Dies beschreiben Ghorbian et al. in ihrem Werk aus 2026, wobei sie unter anderem auf
die Risiken der GenAI-gestützten Programmierung eingehen. So birgt diese das Risiko,
die Qualität der entwickelten Software stark zu gefährden.#cf(<ghorbianLargeLanguageModels2026>, page: "9f")
Dieser Kontrast aus Effizienzversprechen und Qualitätsrisiken zeigt sich heute besonders
deutlich im Wandel von Low-Code-Plattformen wie ServiceNow.#cf(<liuEmpiricalStudyLowcode2026a>, page: 4) Wie Liu et al. belegen,
integrieren diese Systeme zunehmend GenAI-gestützte Code-Generierung, was in der
Praxis zu großen Zuverlässigkeitsbedenken führt und zwingend menschliches
Fachwissen zur Validierung erfordert.#cf(<liuEmpiricalStudyLowcode2026a>, page: 9) Um genau dieses Spannungsfeld zwischen
potenziellen Effizienzgewinnen und drohenden Qualitätsverlusten in der industriellen
Praxis systematisch zu evaluieren, untersucht die vorliegende Arbeit den Einsatz von
GenAI anhand praxisnaher Entwicklungsszenarien in ServiceNow.

== Forschungsfrage

Ausgehend von der dargelegten Motivation verfolgt die vorliegende Arbeit das Ziel, den Einsatz von #abbr("GenAI", "Generative Artificial Intelligence") bei der Code-Generierung in ServiceNow-Implementierungsprojekten empirisch zu untersuchen. Dabei werden sowohl die technische als auch die wirtschaftliche Perspektive berücksichtigt, da ein Effizienzgewinn durch generative KI nur dann einen echten Mehrwert für IT-Dienstleister darstellt, wenn er nicht zulasten der Softwarequalität geht und sich zugleich betriebswirtschaftlich sinnvoll einordnen lässt.
Daraus ergibt sich die folgende, forschungsleitende Frage dieser Arbeit:


Welche technischen und wirtschaftlichen Auswirkungen hat der Einsatz generativer künstlicher Intelligenz auf die Code-Generierung in ServiceNow-Implementierungsprojekten?

Im Verlauf der Arbeit werden nach dem Erarbeiten der theoretischen Grundlagen zur Beantwortung dieser Frage mehrere Hypothesen abgeleitet. Diese dienen zur systematischen Beantwortung der Frage, indem sie die Auswirkungen des Einsatzes von #abbr("GenAI", "Generative Artificial Intelligence") auf die Effizienz und Qualität der Code-Generierung in ServiceNow-Projekten operationalisieren. Nachdem die Hypothesen im Rahmen eines kontrollierten Experiments empirisch untersucht wurden, werden die Ergebnisse abschließend zusammengeführt und in Bezug auf die Forschungsfrage interpretiert.

== Methodisches Vorgehen

Zur Beantwortung der aufgestellten Forschungsfrage verfolgt die vorliegende Arbeit den folgenden methodischen Ansatz, um sowohl die theoretischen Grundlagen, die Hypothesen als auch die empirische Evidenz zu erarbeiten.

Zunächst wird eine systematische Literaturrecherche nach vom Brocke et al. durchgeführt, um die theoretischen Grundlagen zu ServiceNow, #abbr("GenAI", "Generative Artificial Intelligence") sowie zur Effizienz- und Qualitätsmessung in der Softwareentwicklung zu erarbeiten und die Forschungshypothesen theoriegeleitet abzuleiten.#cf(<vombrockeStandingShouldersGiants2015>, page: "205ff") 

Zur Festlegung geeigneter Messkriterien für das nachfolgende Experiment wird ergänzend der ursprünglich von Basili und Rombach entwickelte Goal-Question-Metric-Ansatz herangezogen.#cf(<basiliGoalQuestionMetric1994>, page: "528ff")

Im Zentrum der Arbeit steht anschließend ein kontrolliertes Experiment, das sich am Prozessmodell von Wohlin et al. mit den Phasen Scoping, Planning, Operation, Analysis and Interpretation sowie Presentation orientiert. Dabei bearbeiten Entwickler aus dem ServiceNow-Umfeld vergleichbare Entwicklungsaufgaben jeweils einmal mit und einmal ohne Unterstützung durch #abbr("GenAI", "Generative Artificial Intelligence"), sodass Unterschiede in Entwicklungseffizienz und Codequalität empirisch erfasst werden können.#cf(<wohlinExperimentationSoftwareEngineering2024>, page: "109ff")

Die detaillierte methodische Vorgehensweise wird in @methodischesForschungsdesign ausführlich dargelegt und begründet. Dort werden auch die Gütekriterien der empirischen Software-Engineering-Forschung sowie die konkrete Operationalisierung der Messkriterien für das Experiment erläutert. Außerdem wird dort die Auswahl der Probanden, die Gestaltung der Aufgabenstellung sowie die Durchführung des Experiments beschrieben.

== Aufbau der Arbeit