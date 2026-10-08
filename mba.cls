%----------------------------------------------------------------------
% MBA thesis LaTeX Class
% 
% Copyright (c) 2026, Marvin Fette
%
% Please read the README.md for instructions on how to use this template.
%----------------------------------------------------------------------
% Class identification
%----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mba}[2026/04/15 MBA thesis class]
%----------------------------------------------------------------------
% Class Options
%----------------------------------------------------------------------
% Bibiliography reference style
\newif\ifieee
\DeclareOption{ieee}{\ieeetrue}
\newif\ifwmaainf
\DeclareOption{wmaainf}{\wmaainftrue}
\newif\ifapa
\DeclareOption{apa}{\apatrue}
% Document Type
\newif\ifma
\DeclareOption{master}{\matrue}
\newif\ifba
\DeclareOption{bachelor}{\batrue}
\newif\ifrep
\DeclareOption{report}{\reptrue}
% Language for standard headings
\newif\ifde
\DeclareOption{german}{\detrue}
\newif\ifen
\DeclareOption{english}{\entrue}
% Cover layout
\newif\ifsinglepage
\DeclareOption{singlepage}{\singlepagetrue}
\DeclareOption{doublepage}{\singlepagefalse}
\ProcessOptions\relax
% Validate that a document type is set
\ifma\else\ifba\else\ifrep\else
	\ClassError{mba}{Document type not set}{Set either master, bachelor, or report document type option}
\fi\fi\fi
%----------------------------------------------------------------------
% Class Loading
%----------------------------------------------------------------------
\LoadClass[12pt,twoside,openright]{report}
%----------------------------------------------------------------------
% Define the primary color for the document
%----------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{ohmRed}{HTML}{C72426}
%----------------------------------------------------------------------
% Packages
%----------------------------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage{setspace}
\RequirePackage{float}
\RequirePackage{url}
\RequirePackage[final]{graphicx}
\RequirePackage{ragged2e}
\RequirePackage{parskip}
\RequirePackage{enumitem}
\setlist{topsep=4pt,itemsep=2pt,parsep=0pt,partopsep=0pt}
\RequirePackage[utf8]{inputenc}
\RequirePackage[
	acronym,
	nonumberlist,
	nopostdot
]{glossaries}
\RequirePackage{environ}
\RequirePackage{blindtext}
\RequirePackage{svg}
\RequirePackage{caption}
\RequirePackage{tabularx}
%----------------------------------------------------------------------
% Useable Commands
%----------------------------------------------------------------------
% Abstract and Kurzdarstellung storage
\newcommand{\theabstract}{}
\RenewEnviron{abstract}{\global\let\theabstract\BODY}
\newcommand{\thekurzdarstellung}{}
\NewEnviron{kurzdarstellung}{\global\let\thekurzdarstellung\BODY}
% Acknowledgements storage
\newcommand{\theacknowledgements}{}
\NewEnviron{acknowledgements}{\global\let\theacknowledgements\BODY}
% Command to add a supervisor to the title page, supports multiple supervisors
\newcommand{\thesupervisors}{}
\newif\ifhasSupervisors
\newif\ifhasMultipleSupervisors
\newcommand{\supervisor}[1]
{
	\ifhasSupervisors
		\expandafter\def\expandafter\thesupervisors\expandafter{\thesupervisors \newline #1}
		\hasMultipleSupervisorstrue
	\else
		\expandafter\def\expandafter\thesupervisors\expandafter{#1}
	\fi
	\hasSupervisorstrue
}
% Command to add an examiner to the title page, supports multiple examiners
\newcommand{\theexaminers}{}
\newif\ifhasExaminers
\newif\ifhasMultipleExaminers
\newcommand{\examiner}[1]
{
	\ifhasExaminers
		\expandafter\def\expandafter\theexaminers\expandafter{\theexaminers \newline #1}
		\hasMultipleExaminerstrue
	\else
		\expandafter\def\expandafter\theexaminers\expandafter{#1}
	\fi
	\hasExaminerstrue
}
% Command to create a list of keywords for the title page, supports multiple keywords
\newcommand{\thekeywords}{}
\newif\ifhasKeywords
\newif\ifhasMultipleKeywords
\newcommand{\keyword}[1]
{
	\ifhasKeywords
		\expandafter\def\expandafter\thekeywords\expandafter{\thekeywords, #1}
		\hasMultipleKeywordstrue
	\else
		\expandafter\def\expandafter\thekeywords\expandafter{#1}
	\fi
	\hasKeywordstrue
}
% Command to reference a repository
\newcommand{\therepository}{}
\newif\ifhasRepository
\newcommand{\repository}[1]
{
	\expandafter\def\expandafter\therepository\expandafter{#1}
	\hasRepositorytrue
}
% Command to reference a company for the title page
\newcommand{\thecompany}{}
\newif\ifhasCompany
\newcommand{\company}[1]
{
	\expandafter\def\expandafter\thecompany\expandafter{#1}
	\hasCompanytrue
}
% Command to declare the subject for the report
\newcommand{\thesubject}{}
\newif\ifhasSubject
\newcommand{\subject}[1]
{
	\expandafter\def\expandafter\thesubject\expandafter{#1}
	\hasSubjecttrue
}
\newcommand{\theauthor}{\@author}
% Command to set the student id printed below the author on the title page
\newcommand{\thestudentid}{}
\newif\ifhasStudentId
\newcommand{\studentid}[1]
{
	\expandafter\def\expandafter\thestudentid\expandafter{#1}
	\hasStudentIdtrue
}
%----------------------------------------------------------------------
% Paper and format settings
%----------------------------------------------------------------------
\RequirePackage[a4paper,twoside,inner=2.75cm,outer=2.75cm,bindingoffset=5mm,top=3.5cm,bottom=1.5cm,headheight=15pt]{geometry}
\setlength{\marginparwidth}{2cm}
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[LE,RO]{\thepage}
\fancyhead[RE]{\rightmark}
\fancyhead[LO]{\leftmark}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\chaptermark}[1]{\markboth{\itshape\chaptername\ \thechapter:\ #1}{}}
\renewcommand{\sectionmark}[1]{\markright{\itshape Section\ \thesection:\ #1}}
\fancypagestyle{plain}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}
\captionsetup[table]{position=bottom}
\captionsetup{width=0.95\textwidth} 
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{3}
%----------------------------------------------------------------------
% Code listings
%----------------------------------------------------------------------
\RequirePackage{minted}
\setminted{xleftmargin=2\parindent,linenos,breaklines,numbersep=10pt}
%----------------------------------------------------------------------
% Language settings
%----------------------------------------------------------------------
\ifde
	% Import German language settings
	\RequirePackage[english, ngerman]{babel}
	% Redefine standard names for German
	\newcommand{\faculty}{Fakult\"{a}t Informatik}
	\newcommand{\studentidname}{Matrikelnummer}
	% Set standard names
	\ifma \newcommand{\type}{Masterarbeit}
	\else \ifba \newcommand{\type}{Bachelorarbeit}
	\else \ifrep \newcommand{\type}{Bericht}
	\fi\fi\fi
	% Override list and reference names
	\renewcommand{\contentsname}{Inhaltsverzeichnis}
	\renewcommand{\listtablename}{Tabellenverzeichnis}
	\renewcommand{\listfigurename}{Abbildungsverzeichnis}
	\renewcommand{\listoflistingscaption}{Quellcodeverzeichnis}
	\renewcommand{\bibname}{Referenzen}
\else
	\ifen
		% Redefine standard names for English
		\newcommand{\faculty}{Faculty of Computer Science}
		\newcommand{\studentidname}{Student ID}
		% Set standard names
		\ifma \newcommand{\type}{Master Thesis}
		\else \ifba \newcommand{\type}{Bachelor Thesis}
		\else \ifrep \newcommand{\type}{Report}
		\fi\fi\fi
		% Override list and reference names
		\renewcommand{\contentsname}{Table of Contents}
		\renewcommand{\listtablename}{List of Tables}
		\renewcommand{\listfigurename}{List of Figures}
		\renewcommand{\listoflistingscaption}{List of Listings}
		\renewcommand{\bibname}{References}
	\else
		\ClassError{mba}{Language not set}{Set either de or en language option}
	\fi
\fi
%----------------------------------------------------------------------
% Hyperref and PDF metadata
%----------------------------------------------------------------------
% Write XMP metadata file with expanded macros before pdfx reads it
\newwrite\xmpdatafile
\AtBeginDocument{%
	\immediate\openout\xmpdatafile=\jobname.xmpdata\relax
	\immediate\write\xmpdatafile{\string\Title{\@title}}%
	\immediate\write\xmpdatafile{\string\Author{\@author}}%
	\immediate\write\xmpdatafile{\string\Keywords{\thekeywords}}%
	\immediate\closeout\xmpdatafile
}
\RequirePackage[a-2b,mathxmp]{pdfx}
\ifapa\else
\RequirePackage[hyperpageref]{backref}
\ifde
	\renewcommand*{\backref}[1]{}
	\renewcommand*{\backrefalt}[4]{%
		\ifcase #1 (Nicht zitiert.)%
		\or (Zitiert auf Seite~#2.)%
		\else (Zitiert auf Seiten~#2.)%
		\fi
	}
\else
	\renewcommand*{\backref}[1]{}
	\renewcommand*{\backrefalt}[4]{%
		\ifcase #1 (Not cited.)%
		\or (Cited on page~#2.)%
		\else (Cited on pages~#2.)%
		\fi
	}
\fi
\fi
% Implement a command for full references that include both the number and the name of the referenced element
\newcommand*{\fullref}[1]{\hyperref[{#1}]{\ref*{#1}\mbox{,}~\nameref*{#1}}}

% Set PDF metadata
\hypersetup{%
	bookmarksopen=true,
	bookmarksnumbered=true,
	bookmarksopenlevel=1,
	plainpages=false,
	hypertexnames=true,
	linktocpage=true
}
%----------------------------------------------------------------------
% Shortcuts
%----------------------------------------------------------------------
\newcommand{\ua}{\mbox{u.\,a.\ }}
\newcommand{\zB}{\mbox{z.\,B.\ }}
\newcommand{\dahe}{\mbox{d.\,h.,\ }}
\newcommand{\bzw}{\mbox{bzw.\ }}
\newcommand{\bzgl}{\mbox{bzgl.\ }}
\newcommand{\eg}{\mbox{e.\,g.\ }}
\newcommand{\ie}{\mbox{i.\,e.\ }}
\newcommand{\wrt}{\mbox{w.\,r.\,t.\ }}
\newcommand{\etal}{\mbox{\emph{et\,al.\ }}}
%---------------------------------------------------------------------
% bibliography settings
%---------------------------------------------------------------------
% Set bibliography style based on class options
\ifapa
\RequirePackage{csquotes}
\RequirePackage[backend=biber,style=apa]{biblatex}
\addbibresource{refs.bib}
\else
\ifieee
\ifde \bibliographystyle{format/deIEEEtran}
\else \bibliographystyle{ieeetr}
\fi
\else
\ifwmaainf
\bibliographystyle{format/wmaainf}
	\else
\ClassError{mba}{Bibliography style not set}{Set ieee, wmaainf, or apa bibliography style}
	\fi
\fi
\fi
%----------------------------------------------------------------------
% Document structure and page numbering
%----------------------------------------------------------------------
% Front matter: roman page numbers, counted from the cover page onwards.
% Call this before \maketitle.
\newcommand{\frontmatter}{
	\clearpage
	\pagenumbering{roman}
}
% Main matter uses Arabic numbering; front and back matter share Roman numbering.
\newcounter{ohmfrontmatterpage}
\newcommand{\mainmatter}{
	\clearpage
	\setcounter{ohmfrontmatterpage}{\value{page}}
	\pagenumbering{arabic}
	\onehalfspacing
	\justifying
}
\newcommand{\backmatter}{
	\clearpage
	\pagenumbering{Roman}
	\setcounter{page}{\value{ohmfrontmatterpage}}
}
%----------------------------------------------------------------------
% Title and copyright pages
%----------------------------------------------------------------------
\renewcommand{\maketitle}{
	\begin{titlepage}
		\thispagestyle{empty}
		\centering
		\vspace*{1cm}
		{\LARGE\bfseries \@title\par}
		\vspace{1.25cm}
		{\large
			A thesis submitted in partial fulfillment of the requirements\par
			for the degree of\par
		}
		\vspace{0.5cm}
		{\Large\bfseries Master of Business Administration (MBA)\par}
		\vspace{0.5cm}
		{\large at the\par}
		{\large\bfseries WiSo Executive School\par}
		{\large Friedrich-Alexander University Erlangen-Nuremberg\par}
		\vfill
		\begin{minipage}{0.8\textwidth}
			\raggedright
			\textbf{Submitted by:}\par
			\vspace{0.4cm}
			\begin{tabularx}{\linewidth}{@{}lX@{}}
				Author: & \@author\\[0.8ex]
				Student ID: & \thestudentid\\[0.8ex]
				Programme: & MBA in Digital Business \& AI
			\end{tabularx}
		\end{minipage}
		\vfill
		\noindent
		\begin{minipage}[b]{0.45\textwidth}
			\rule{\linewidth}{0.4pt}\\
			\@author
		\end{minipage}
		\hfill
		\begin{minipage}[b]{0.45\textwidth}
			\raggedleft
			Nuremberg, \@date
		\end{minipage}
	\end{titlepage}
	\clearpage
	\thispagestyle{empty}
	\vspace*{\fill}
	\begin{center}
		\copyright\;\;\@author,\;\the\year
	\end{center}
	\vspace{1.5em}
	\noindent
	This work, including its parts, \textbf{is protected by copyright}.
	Any use outside the narrow limits of copyright law without the consent of the author is prohibited and punishable by law.
	This applies in particular to reproductions, translations, microfilming and storage and processing in electronic systems.
	\vspace*{\fill}
	\clearpage
	\setcounter{page}{3}
}
%----------------------------------------------------------------------
% Table of content
%----------------------------------------------------------------------
\newcommand{\maketableofcontents}{
	\pdfbookmark[0]{\contentsname}{contents}
	\tableofcontents
}
%----------------------------------------------------------------------
% Abstract, Keywords, and Kurzdarstellung
%----------------------------------------------------------------------
\newcommand{\makeabstract}{
	\chapter*{\ifde Kurzdarstellung\else Abstract\fi}
	\label{ch:abstract}
	\ifen
		\theabstract
	\else
		\thekurzdarstellung
	\fi
	\ifhasKeywords
		\section*{\ifde Schlagwörter\else Keywords\fi}
		\label{sec:keywords}
		\thekeywords
	\fi
%	\pagebreak
%	\ifen
%		\thispagestyle{empty}
%		\section*{\ifde Kurzdarstellung\else Kurzdarstellung\fi}
%		\label{sec:kurzdarstellung}
%		\thekurzdarstellung
%	\fi
}
%----------------------------------------------------------------------
% Acknowledgements
%----------------------------------------------------------------------
\newcommand{\makeacknowledgements}{
	\ifrep
	\else
		\ifx\theacknowledgements\empty\else
			\chapter*{\ifde Danksagung\else Acknowledgements\fi}
			\label{ch:acknowledgements}
			\theacknowledgements
		\fi
	\fi
}
%----------------------------------------------------------------------
% Acronyms
%----------------------------------------------------------------------
\newcommand{\makeacronyms}{
	\begin{small}
		\printnoidxglossary[type=\acronymtype,title={\ifde Abk\"{u}rzungsverzeichnis\else List of Acronyms\fi}]
	\end{small}
}
%----------------------------------------------------------------------
% Glossary and Lexicon
%----------------------------------------------------------------------
\newcommand{\makelexicon}{
	\begin{small}
		\printnoidxglossary[type=main,title={\ifde Glossar\else Glossary\fi}]
	\end{small}
}
%----------------------------------------------------------------------
% Bibliography
%----------------------------------------------------------------------
\newcommand{\makebibliography}{
	\begin{small}
		\ifapa
			\printbibliography
		\else
			\bibliography{refs}
		\fi
	\end{small}
}
