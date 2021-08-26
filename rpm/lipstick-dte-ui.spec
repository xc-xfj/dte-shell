Name:       lipstick-dte-ui
Summary:    A nice homescreen for DTE experience
Version:    0.1
Release:    1
Group:      System/GUI/Other
License:    BSD
URL:        https://github.com/zorowk/dte-ui
Source0:    %{name}-%{version}.tar.bz2

Requires:   qt5-qtdeclarative
Requires:   qt5-qtquickcontrols
Requires:   lipstick-qt5-devel
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(lipstick-qt5)
Provides: lipstick-dte-ui

Conflicts:   lipstick-example-home

%description
A homescreen for DTE Table

%prep
%setup -q -n %{name}-%{version}

