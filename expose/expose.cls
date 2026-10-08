%----------------------------------------------------------------------
% MBA thesis expose LaTeX class
%----------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{expose}[2026/10/08 MBA thesis expose class]

\LoadClass[10pt,twoside]{article}

\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[english]{babel}
\RequirePackage[a4paper,top=1.6cm,bottom=1.7cm,left=1.8cm,right=1.8cm]{geometry}
\RequirePackage{lmodern}
\RequirePackage{microtype}
\RequirePackage{parskip}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage{multicol}
\RequirePackage{csquotes}
\RequirePackage[backend=biber,style=apa]{biblatex}
\addbibresource{../refs.bib}
\RequirePackage[colorlinks=true,allcolors=blue]{hyperref}
\RequirePackage{tabularx}
\RequirePackage{titlesec}

\setlength{\columnsep}{0.65cm}
\setlength{\parindent}{0pt}
\setlist{nosep,leftmargin=*}
\setlength{\headheight}{12pt}
\pagestyle{fancy}
\fancyhf{}
\fancyhead[L]{\footnotesize Exposé}
\fancyhead[R]{\footnotesize \theauthor}
\fancyfoot[C]{\footnotesize \thepage\ of \pageref*{LastPage}}
\renewcommand{\headrulewidth}{0.3pt}
\titleformat{\section}{\normalsize\bfseries}{\thesection.}{0.4em}{}
\titlespacing*{\section}{0pt}{0.55em}{0.2em}
\titleformat{\subsection}{\small\bfseries}{\thesubsection.}{0.4em}{}
\titlespacing*{\subsection}{0pt}{0.4em}{0.15em}

\newcommand{\thestudentid}{}
\newcommand{\studentid}[1]{\gdef\thestudentid{#1}}
\newcommand{\theexaminer}{}
\newcommand{\examiner}[1]{\gdef\theexaminer{#1}}
\newcommand{\theprogram}{}
\newcommand{\program}[1]{\gdef\theprogram{#1}}
\newcommand{\theinstitution}{}
\newcommand{\institution}[1]{\gdef\theinstitution{#1}}

\makeatletter
\newcommand{\theauthor}{\@author}
\renewcommand{\maketitle}{
    \thispagestyle{empty}
    \begin{center}
        {\Large\bfseries \@title\par}
        \vspace{0.25em}
        {\normalsize Thesis Exposé\par}
        \vspace{0.35em}
        {\small
            \theprogram\par
            \theinstitution\par
        }
    \end{center}
    \vspace{0.3em}
    \begin{tabularx}{\textwidth}{@{}lXlX@{}}
        Submitted to: & \theexaminer &
        Submitted by: & \@author\\
	Date: & \@date &
        Student ID: & \thestudentid
    \end{tabularx}
    \vspace{0.5em}
    \hrule
    \vspace{0.45em}
}
\makeatother

\newcommand{\makebibliography}{
    \printbibliography
}
