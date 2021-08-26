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
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(lipstick-qt5)
BuildRequires:  pkgconfig(Qt5WaylandCompositor)
BuildRequires:  pkgconfig(Qt5WaylandClient)

Provides: lipstick-dte-ui

Conflicts:   lipstick-example-home

%description
A homescreen for DTE Table

%prep
%setup -q -n %{name}-%{version}

%build
mkdir build
cd build
%qmake -DCMAKE_VERBOSE_MAKEFILE=ON ..
qmake --build .

%install
cd build
rm -rf %{buildroot}
DESTDIR=%{buildroot} cmake --build . --target install

mkdir -p %{buildroot}%{_userunitdir}/user-session.target.wants/
ln -s ../lipstick.service %{buildroot}%{_userunitdir}/user-session.target.wants/lipstick.service


