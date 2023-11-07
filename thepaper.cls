%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Template for journal article preprints
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Acknowledgement: The template is based on Lapreprint(http://github.com/Lapreprint/Lapreprint).
% Only slightly modified to suit my needs.
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thepaper}

% List of packages used throughout the document class:
% babel, calc, etoolbox, regexpatch, ifxetex, ifluatex, marginfix,
% amsmath, mdframed, lineno, endfloat
% FONT: unicode-math, opensans
%

\RequirePackage[english]{babel}
\RequirePackage{calc}
\RequirePackage{etoolbox}
\RequirePackage{regexpatch}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{marginfix}  % Solves the issue of long notes running over the bottom of the page

\newif\ifxetexorluatex
\ifxetex
  \xetexorluatextrue
\else
  \ifluatex
    \xetexorluatextrue
  \else
    \xetexorluatexfalse
  \fi
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DOCUMENT CLASS OPTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Line numbers
\newif\if@reqslineno
\DeclareOption{lineno}{\@reqslinenotrue}

%% Endfloats
\newif\if@endfloat
\DeclareOption{endfloat}{\@endfloattrue}

%% Linespacing
\newif\if@onehalfspacing
\DeclareOption{onehalfspacing}{\@onehalfspacingtrue}
\newif\if@doublespacing
\DeclareOption{doublespacing}{\@doublespacingtrue}


%% Section numbers
\newif\if@secnum
\DeclareOption{secnum}{\@secnumtrue}

%%% Provides extra font sizes (? - look up extsizes, https://www.ctan.org/pkg/extsizes) 
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}

\ExecuteOptions{}
\ProcessOptions\relax
\LoadClass{extarticle}

\RequirePackage{amsmath}
\RequirePackage{mdframed}
\RequirePackage{lineno}
\if@reqslineno\linenumbers\fi
\if@endfloat\RequirePackage[nolists,nomarkers]{endfloat}\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% FONT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifxetexorluatex
  \RequirePackage{unicode-math}
  \RequirePackage{fontspec}
  % \RequirePackage[default]{opensans}
  % \setmonofont[Scale=MatchUppercase]{Latin Modern Mono}
  % XITSMath is really STIX. Really.
  % https://tex.stackexchange.com/questions/227216/stix-versus-xits
  \setsansfont{Open Sans}
  \setmainfont{STIX Two Text}
  \setmathfont{STIX Two Math}
  % \setmathfont[Extension = .otf,BoldFont = XITSMath-Bold,]{XITSMath-Regular}
\else
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{stix}
  \RequirePackage[default]{opensans}
  \renewcommand{\ttdefault}{lmtt}
\fi

\RequirePackage{microtype}

% Trueno/Open Sans requires a bigger "single" linespread.
\linespread{1.2}
\if@onehalfspacing\linespread{1.65}\fi
\if@doublespacing\linespread{2.0}\fi
\if@endfloat\AtBeginDelayedFloats{% Also changes for endfloat captions
      \renewcommand{\baselinestretch}{1.2}
      \if@onehalfspacing\renewcommand{\baselinestretch}{1.5}\fi%
      \if@doublespacing\renewcommand{\baselinestretch}{2.0}\fi}\fi

% Colour scheme
\RequirePackage{graphicx}
\RequirePackage[table]{xcolor}

\definecolor{darkColour}{HTML}{0E4B92}
\definecolor{lightColour}{HTML}{357ABF}
\definecolor{MediumGrey}{HTML}{6D6E70}
\definecolor{LightGrey}{HTML}{929497}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PAGE LAYOUT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage{authblk} % redefines \author command - needs to go before {silence}
\RequirePackage[left=1.5cm,%
                marginparwidth=4cm,%
                marginparsep=0.5cm,%
                right=1.5cm,%
                top=2cm,%
                bottom=2.5cm,%
                headheight=21pt,%
                headsep=2\baselineskip,%
                columnsep=2em,%
                letterpaper]{geometry}%
\if@reqslineno\linenumbers\newgeometry{left=1.5cm,%
                marginparwidth=3.5cm,%
                marginparsep=1cm,%
                right=1.5cm,%
                top=2cm,%
                bottom=2.5cm,%
                headheight=21pt,%
                headsep=2\baselineskip,%
                columnsep=2em}\fi
\RequirePackage[strict]{changepage} % strict for use with sidenotes
\RequirePackage{silence}
\WarningFilter{caption}{The option `hypcap=true' will be ignored}
\RequirePackage[labelfont={bf},%
                labelsep=period,%
                justification=raggedright,%
                singlelinecheck=false,%
                tableposition=top,font=small]
                {caption}

% \captionsetup*[table]{skip=\medskipamount}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% HEADERS AND FOOTERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Format title
\if@secnum\else\setcounter{secnumdepth}{0}\fi
\RequirePackage[explicit]{titlesec}
\titleformat{\section}
  {\bfseries\color{darkColour}\scshape}
  {\thesection}{10pt}{#1}[]
\titleformat{\subsection}
  {\bfseries}
  {\thesubsection}{10pt}{#1}[]
\titleformat{\subsubsection}
  {}
  {\thesubsubsection}{10pt}{#1}[]    
\titleformat{\paragraph}
  {\small\itshape}
  {\theparagraph}{10pt}{#1}[]

% Title spacing
\titlespacing*{\section}{0pc}{3ex \@plus4pt \@minus3pt}{2pt}
\titlespacing*{\subsection}{0pc}{2.5ex \@plus3pt \@minus2pt}{1pt}
\titlespacing*{\subsubsection}{0pc}{2ex \@plus2.5pt \@minus1.5pt}{0pt}
\titlespacing*{\paragraph}{0pc}{1.5ex \@plus2pt \@minus1pt}{0pt}
  
\RequirePackage{enumitem}
\setlist{noitemsep}

\RequirePackage{alphalph}
\newalphalph{\fnsymbolmult}[mult]{\@fnsymbol}{5}

\newcounter{authorfn}
\setcounter{authorfn}{1}
\newcommand{\authfn}[1]{%
  \fnsymbolmult{\numexpr\value{authorfn}+#1}%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ADDITIONAL FRONT PAGE META DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\@metadata{}

\newcommand{\metadata}[3][]{%
  \ifx\empty\@metadata\else\appto{\@metadata}{}{}{}\fi
  \appto{\@metadata}{%
    \ifx\empty#2\else\textbf{#2: }\fi
    \ifx\empty#1\else\textsuperscript{#1}\fi
    #3%
    \par\bigskip
  }
}

\reversemarginpar


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CREATE TITLE PAGE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\renewcommand{\Authfont}{\sffamily\bfseries\raggedright\fontsize{12}{12}\selectfont}
\renewcommand{\Affilfont}{\sffamily\mdseries\fontsize{10}{10}\selectfont\raggedright}
\renewcommand{\Authands}{, }
\setlength{\affilsep}{16pt}
\renewcommand{\AB@affilsepx}{; \protect\Affilfont}

\newcommand{\themetadata}{%
    \ifx\empty\@metadata\else
    \@metadata\fi
}

% Insert authors and affiliations
\patchcmd{\@author}{\AB@authlist\\[\affilsep]\AB@affillist}{\AB@authlist\\[\affilsep] 
  \AB@affillist}{}{}

% Insert title
\renewcommand{\maketitle}{%
  \vskip36pt%
  {\color{darkColour}\sffamily\raggedright\bfseries\fontsize{16}{22}\selectfont \@title\par}%
  \vskip16pt
  {\@author\par}
  \vskip8pt
  \thispagestyle{plain}
}

% Insert abstract
\renewenvironment{abstract}{%
   \setlength{\parindent}{0pt}
   \textcolor{MediumGrey}{\rule{\textwidth}{2pt}}
   \vskip8pt
   \textcolor{lightColour}{\large\bfseries\sffamily\abstractname\space}

   % Here we squeeze in the margin metadata
   \marginpar{\raggedright\footnotesize\themetadata\par}
}{%
   \vskip8pt
   \textcolor{MediumGrey}{\rule{\textwidth}{2pt}}
   \vskip8pt
}

%% Insert a grey line to separate floats from main text
\newcommand{\topfigrule}{\vskip8pt\noindent{\rule{\linewidth}{1pt}}}
\newcommand{\botfigrule}{\noindent{\rule{\linewidth}{1pt}}\vskip8pt}



% Hyperlinks
\RequirePackage{hyperref}
\hypersetup{%
  colorlinks=true,
  allcolors=black,
  citecolor=MediumGrey,
  linkcolor=MediumGrey,
  urlcolor=lightColour,
  hypertexnames=false}
\urlstyle{sf}
