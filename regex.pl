s~%global\s+goipath\s+(.*)/(.*)~%global goihead \2\n%global goipath \1/%{goihead}\n~g;
s~(Version:)\s*([^0-9\.]*)([0-9\.]*)([^\s]*)\s*~\1  \3\n%define oldver \2\3\4\nBuildRequires: coreutils\n~g;
s~(^%gometa.*)~%{?!tag:%{?!commit:%global tag v%{oldver}}}\n\1\n~g;
s~(%build.*)~\1\n%{prebuild}\n~g;
s~%gocheck~~g;
s~Source:.*~%define stag %{?tag}%{?!tag:%commit}\nSource0: https://%{goipath}/archive/%{stag}/%{goihead}-%{stag}.tar.gz~g;
