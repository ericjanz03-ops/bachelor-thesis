#import "../lib/style.typ": placeholder
#import "../lib/cite.typ": cf, quot, cf-multi
#import "../lib/abbr.typ": abbr

= Einleitung <einleitung>

== Motivation und Zielsetzung

Bereits 1971 wurde in der anfänglichen Forschung zur automatisierten Synthese von
Softwareprogrammen von Manna und Waldinger beschrieben, dass es oft einfacher ist,
das Ziel einer Berechnung abstrakt zu beschreiben, als den Programmcode dafür explizit
zu definieren.
1 Während diese Vision der automatisierten Code-Generierung historisch
durch starre, deterministische Ansätze und komplexe mathematische Theorembeweise
verfolgt wurde, ist sie heute durch brandaktuelle Large Language Models (LLM) geprägt.
Software kann somit direkt aus natürlicher Sprache generiert werden. So präsentieren
Jiang et al. in ihrer Studie aus dem Januar 2026 eine umfassende Übersicht über diesen
Paradigmenwechsel, den sie als Natural-Language-to-Code definieren.
2 Gleichzeitig
betonen die Autoren jedoch eine Lücke zwischen der rein akademischen Forschung und
der praktischen Softwareentwicklung. Sie stellen fest, dass etablierte, standardisierte
Evaluierungs-Benchmarks die Komplexität und Herausforderungen von realen,
industriellen Entwicklungsszenarien nicht angemessen widerspiegeln.3
Um diese Lücke zwischen akademischer Forschung und industrieller Praxis zu schließen,
fokussiert sich die hier geplante Arbeit auf ServiceNow-Projekte. Historisch war die
Bereitstellung von Unternehmenssoftware stark durch das fundamentale Dilemma
zwischen teurer Individualentwicklung und funktionaler, aber dafür starrer
Standardsoftware geprägt. Dies beschreibt Brooks in einem 1987 veröffentlichten
Fachartikel, in dem er schon damals die anfallenden Entwicklungskosten dem oftmals
günstigeren Kaufpreis für Standardsoftware gegenüberstellt.4 Brooks argumentiert stark
für die Verwendung von Standardsoftware aufgrund der oft guten Dokumentation, breiten
Verfügbarkeit und schnellen Entwicklung.5 Die Relevanz dieses Fokus wird durch die
heutige Marktstellung der ServiceNow-Plattform verdeutlicht. Mit einem globalen
Kundenstamm von über 8100 Unternehmen und einer Durchdringung von mehr als 85 %
der Fortune-500-Unternehmen hat sich ServiceNow zu einem der wichtigsten
Standardsoftware-Lieferanten auf dem gesamten Markt etabliert.6 Folglich ist die
1 Vgl. Manna, Z. & Waldinger, R. J. (1971), S. 151.
2 Vgl. Jiang, J. et al. (2026), S. 8.
3 Vgl. ebd., S. 55.
4 Vgl. Brooks, F. P. (1987), S. 16f.
5 Vgl. ebd.
6 Vgl. ServiceNow, Inc. (2026), S. 2.
2
Implementierung von ServiceNow und somit die Softwareentwicklung bzw.
Softwarekonfiguration der Plattform, welche auf den Low-Code-Ansatz setzt, von großer
wirtschaftlicher Bedeutung.
Genau in diesem bedeutenden Umfeld der Softwareentwicklung verspricht der Einsatz
von generativer künstlicher Intelligenz, im Englischen Generative Artificial Intelligence
(GenAI), die Entwicklungseffizienz drastisch zu steigern. Die empirische Studie von
Peng et al. aus dem Jahr 2023 belegt dabei eine Ersparnis in der Entwicklungszeit von bis
zu 55,8 % unter Nutzung von GitHub Copilot.7 Dieser enorme Effizienzgewinn geht
jedoch unweigerlich mit neuen, komplexen Herausforderungen für die Softwarequalität
einher. Im Gegensatz zu traditionellen, deterministischen und regelbasierten Methoden
arbeiten moderne LLMs bei der Code-Generierung rein stochastisch und datengetrieben.
Dies beschreiben Ghorbian et al. in ihrem Werk aus 2026, wobei sie unter anderem auf
die Risiken der GenAI-gestützten Programmierung eingehen. So birgt diese das Risiko,
die Qualität der entwickelten Software stark zu gefährden.8
Dieser Kontrast aus Effizienzversprechen und Qualitätsrisiken zeigt sich heute besonders
deutlich im Wandel von Low-Code-Plattformen wie ServiceNow.9 Wie Liu et al. belegen,
integrieren diese Systeme zunehmend GenAI-gestützte Code-Generierung, was in der
Praxis zu großen Zuverlässigkeitsbedenken führt und zwingend menschliches
Fachwissen zur Validierung erfordert.10 Um genau dieses Spannungsfeld zwischen
potenziellen Effizienzgewinnen und drohenden Qualitätsverlusten in der industriellen
Praxis systematisch zu evaluieren, untersucht die vorliegende Arbeit den Einsatz von
GenAI anhand praxisnaher Entwicklungsszenarien in ServiceNow.