\@ifl@t@r\fmtversion{2018/04/01}{\UseRawInputEncoding}{}
\ProvidesClass{template}

%% v1.1: Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\newif\if@raggedtwoe
\DeclareOption{ragged2e}{\@raggedtwoetrue}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=0cm]{geometry}
\RequirePackage{fontawesome}
\RequirePackage{ifxetex,ifluatex}
\RequirePackage{scrlfile}

%% v1.1.5: added for convenience
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

%% v1.1: Optionally load academicons
%% v1.1.5: Handle different versions of academicons
\if@academicons
  \ifxetexorluatex
    \RequirePackage{fontspec}
    %% academicons in TL2018 doesn't require
    %% Academicons to be installed in OS fonts
    %% so can be loaded directly
    \@ifl@t@r\fmtversion{2018/04/01}{%
      \RequirePackage{academicons}
    }{%
      % TL2017
      \@ifl@t@r\fmtversion{2017/04/01}{%
        \@ifpackagelater{academicons}{2018/03/01}{%
          \RequirePackage{academicons}
        }{%
          \let\ori@newfontfamily\newfontfamily%
          \renewcommand{\newfontfamily}[2]{}
          \RequirePackage{academicons}
          \let\newfontfamily\ori@newfontfamily
          \newfontfamily{\AI}{academicons.ttf}
        }
      }{% TL2016 requires the package to be loaded before
        % the version can be checked. Only added because
        % Overleaf v1 still runs TL2016; will be removed
        % when v1 is completely retired.
          \let\ori@newfontfamily\newfontfamily%
          \renewcommand{\newfontfamily}[2]{}
          \RequirePackage{academicons}
          \let\newfontfamily\ori@newfontfamily
          \newfontfamily{\AI}{academicons.ttf}
      }
    }
  \else
    \ClassError{AltaCV}{academicons unsupported by latex or pdflatex. Please compile with xelatex or lualatex}{Please compile with xelatex or lualatex to use the academicons option}
  \fi
\fi

\if@raggedtwoe
  \RequirePackage[newcommands]{ragged2e}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\colorlet{headingwhite}{white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
\usepackage{afterpage}
\usepackage{hyperref}
\RequirePackage{marginfix}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

\newenvironment{changemargin}[2]{%
\begin{list}{}{%
\setlength{\topsep}{0pt}%
\setlength{\leftmargin}{#1}%
\setlength{\rightmargin}{#2}%
\setlength{\listparindent}{\parindent}%
\setlength{\itemindent}{\parindent}%
\setlength{\parsep}{\parskip}%
}%
\item[]}{\end{list}}


\newcommand{\emailsymbol}{\faAt}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\faEnvelope}

\newcommand{\printinfo}[2]{\mbox{\textcolor{headingwhite}{\normalfont #1}\hspace{0.5em}#2\hspace{2em}}}

\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
\newcommand{\photo}[2]{\def\@photo{#2}\def\@photodiameter{#1}}
\newcommand{\email}[1]{\makebox[0.6\linewidth][l]{\printinfo{\emailsymbol}{\href{mailto:#1}{#1}}}}
\newcommand{\mailaddress}[1]{\printinfo{\mailsymbol}{#1}}
\newcommand{\phone}[1]{\makebox[0.3\linewidth][l]{\printinfo{\phonesymbol}{\href{tel:#1}{#1}}}}
\newcommand{\homepage}[1]{\makebox[0.3\linewidth][l]{\printinfo{\homepagesymbol}{\href{https://#1}{#1}}}}
% \newcommand{\homepage}[1]{\printinfo{\homepagesymbol}{\href{https://#1}{#1}}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{\href{https://#1}{#1}}}
\newcommand{\linkedin}[1]{\makebox[0.6\linewidth][l]{\printinfo{\linkedinsymbol}{\href{https://#1}{#1}}}}
% \newcommand{\linkedin}[1]{\printinfo{\linkedinsymbol}{\href{https://#1}{#1}}}
\newcommand{\github}[1]{\makebox[0.6\linewidth][l]{\printinfo{\githubsymbol}{\href{https://#1}{#1}}}}
% \newcommand{\github}[1]{\printinfo{\githubsymbol}{\href{https://#1}{#1}}}
\newcommand{\orcid}[1]{\printinfo{\orcidsymbol}{#1}}
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}

\newcommand{\personalinfo}[1]{\def\@personalinfo{#1}}

\newcommand{\makecvheader}{%
   \begin{tcolorbox}[enhanced jigsaw, 
 colback=DarkGrey, % black background
 coltext=white, % white text
 halign=left, % center
 fontupper={\Huge \bfseries}, % change the font here
 sharp corners, % no rounded corners
 colframe=black, % not really necessary
 boxrule=0pt % frame off 
 ]
 \vspace{0.5cm}
 
 \begin{changemargin}{0.75cm}{2cm}
  \begingroup
    \ifdef{\@photodiameter}{\begin{minipage}{\dimexpr\linewidth-\@photodiameter-2em}}{}%
    \raggedright%
    {\Huge\bfseries\MakeUppercase{\@name}\par}
    \medskip
    {\LARGE\bfseries\@tagline\par}
    \bigskip
    {\large\bfseries\@personalinfo\par}
    \ifdef{\@photodiameter}{%
    \end{minipage}\hfill%
    \begin{minipage}{\@photodiameter}
    \if@normalphoto
      \includegraphics[width=\linewidth]{\@photo}
    \else
      \tikz\path[fill overzoom image={\@photo}]circle[radius=0.5\linewidth];
    \fi%
    \end{minipage}\par}{}%
  \endgroup\medskip
    
    \end{changemargin}

\end{tcolorbox}
}

\newcommand{\summary}[1]{%
\bigskip%
\begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{\dimexpr\linewidth-2.5cm}   
  {\color{emphasis}\large\normalfont{#1}\par}\medskip
    \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
}

\newcommand{\cvsection}[2][]{%
  \bigskip%
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{\dimexpr\linewidth-2.5cm}   
  \ifstrequal{#1}{}{}{\marginpar{\vspace*{\dimexpr1pt-\baselineskip}\raggedright\input{#1}}}%
  {\color{heading}\LARGE\normalfont\MakeUppercase{#2}}\\[-1ex]%
  {\color{line}\rule{\linewidth}{1pt}\par}\medskip
  \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
}

% v1.1.4: fixes inconsistent font size
% \newcommand{\cvevent}[3]{%
% \begin{minipage}{1.25cm}   
%     \hfill
%   \end{minipage}
%   \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
%     {{\large\color{emphasis}{#1}}}%
%   \end{minipage}
%   \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}   
%     {\Large\textbf{\color{accent}#2}}\par%
%   \end{minipage}
%   \begin{minipage}{1.25cm}   
%     \hfill
%   \end{minipage}
%   \begin{minipage}{1.25cm}   
%     \hfill
%   \end{minipage}
%   \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
%     \hfill
%   \end{minipage}
%   \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}  
%     {\itshape{\color{accent}#3}}%
%     \medskip
%   \end{minipage}
  
%   \begin{minipage}{1.25cm}   
%     \hfill
%   \end{minipage}
  
% }

\newcommand{\cvevent}[4]{%
\begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
    {{\large\color{emphasis}{#1}}}%
  \end{minipage}
  \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}   
    {\Large\textbf{\color{accent}#2}}\par%
  \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  
  \smallskip
  
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}  
    {\itshape{\color{accent}#3}}\par%
  \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  
  \medskip
  
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}  
    \responsibilities #4
  \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \bigskip
}
\newcommand{\responsibilities}[5]{% 
          \begin{minipage}[t]{\linewidth}  
            \begin{itemize}
            \item #1
            \ifstrequal{#2}{}{}{\item #2}
            \ifstrequal{#3}{}{}{\item #3}
            \ifstrequal{#4}{}{}{\item #4}
            \ifstrequal{#5}{}{}{\item #5}
            \end{itemize}
          \end{minipage}%
}

% \newcommand{\responsibilities}[5]{% 
% \begin{minipage}{1.25cm}   
%     \hfill
%   \end{minipage}
%     \begin{minipage}[t]{0.3\dimexpr\linewidth-2.5cm}  
%             \hfill%
%           \end{minipage}
%           \begin{minipage}[t]{0.7\dimexpr\linewidth-2.5cm}  
%             \begin{itemize}
%             \item #1
%             \ifstrequal{#2}{}{}{\item #2}
%             \ifstrequal{#3}{}{}{\item #3}
%             \ifstrequal{#4}{}{}{\item #4}
%             \ifstrequal{#5}{}{}{\item #5}
%             \end{itemize}
%           \end{minipage}%
%           \bigskip
%           \begin{minipage}{1.25cm}   
%     \hfill
%   \end{minipage}
% }

\newcommand{\customitems}[9]{% first param is the heading and others are points
\begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
          \begin{minipage}[t]{0.3\dimexpr\linewidth-2.5cm}  
            \ifstrequal{#1}{}{}{{{\large\color{emphasis}\textbf{#1}}}}\hfill%
          \end{minipage}
          \begin{minipage}[t]{0.7\dimexpr\linewidth-2.5cm}  
          \smallskip
            \begin{itemize}
            \item #2
            \ifstrequal{#3}{}{}{\item #3}
            \ifstrequal{#4}{}{}{\item #4}
            \ifstrequal{#5}{}{}{\item #5}
            \ifstrequal{#6}{}{}{\item #6}
            \ifstrequal{#7}{}{}{\item #7}
            \ifstrequal{#8}{}{}{\item #8}
            \ifstrequal{#9}{}{}{\item #9}
            \end{itemize}
          \end{minipage}%
          \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
}

\newcommand{\project}[4]{%
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
    \ifstrequal{#1}{}{}{{\large\color{emphasis}{#1}}}\hfill%
  \end{minipage}
  \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}
    {\Large\textbf{\color{accent}#2}}\par%
  \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  
  \smallskip
  
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.3\dimexpr\linewidth-2.5cm}   
    \hfill
  \end{minipage}
  \begin{minipage}{0.7\dimexpr\linewidth-2.5cm}   
    {\itshape{\color{accent}#3}}\par%
    \medskip
    {\itshape{\color{link}\href{#4}{#4}}}\par%
    \medskip
  \end{minipage}
  \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
  \medskip
}

\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{emphasis}\large\bfseries{#1}\par}\medskip
}

\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

\newcommand{\cvskill}[2]{%
\begin{minipage}{0.8\linewidth}  
  \raggedright
  \textcolor{accent}{#1}\hfill
  \end{minipage}%
  \begin{minipage}{0.2\linewidth}  
  \raggedleft 
    \foreach \x in {1,...,5}{%
  \space{\ifnumgreater{\x}{#2}{\color{body!30}}{\color{accent}}\ratingmarker}}\par%    
  \end{minipage}
  \smallskip
}

\newcommand{\markskill}[1]{%
\raggedleft
    \foreach \x in {1,...,5}{%
  \space{\ifnumgreater{\x}{#1}{\color{body!30}}{\color{accent}}\ratingmarker}}\par%    
}

\newcommand{\customskills}[9]{% first param is the heading and others are points
\begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
          \begin{minipage}[t]{0.3\dimexpr\linewidth-2.5cm}  
            \ifstrequal{#1}{}{}{{{\large\color{emphasis}\textbf{#1}}}}\hfill%
          \end{minipage}
          \begin{minipage}[t]{0.7\dimexpr\linewidth-2.5cm}  
          \smallskip
            \begin{itemize}[label={}]
            \item \cvskill #2
            \ifstrequal{#3}{}{}{\item \cvskill #3}
            \ifstrequal{#4}{}{}{\item \cvskill #4}
            \ifstrequal{#5}{}{}{\item \cvskill #5}
            \ifstrequal{#6}{}{}{\item \cvskill #6}
            \ifstrequal{#7}{}{}{\item \cvskill #7}
            \ifstrequal{#8}{}{}{\item \cvskill #8}
            \ifstrequal{#9}{}{}{\item \cvskill #9}
            \end{itemize}
          \end{minipage}%
          \begin{minipage}{1.25cm}   
    \hfill
  \end{minipage}
          \bigskip
}

\newcommand{\cvref}[3]{%
  \smallskip
  \textcolor{emphasis}{\textbf{#1}}\par
  \begin{description}[font=\color{accent},style=multiline,leftmargin=1.35em]
  \item[\normalfont\emailsymbol] #2
  \item[\small\normalfont\mailsymbol] #3
  \end{description}
%   \medskip
}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}