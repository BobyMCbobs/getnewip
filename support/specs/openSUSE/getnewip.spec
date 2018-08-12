Name:           getnewip
Version:        2.2
Release:        1%{?dist}
Summary:        Remote server IP to SSH config hostname manager
BuildArch:	noarch
License:        GPL-3.0
Group:		Productivity/Networking/System
URL:            https://gitlab.com/BobyMCbobs/%{name}
Source0:        https://gitlab.com/BobyMCbobs/%{name}/-/archive/%{version}/%{name}-%{version}.zip
Requires:       bash, netcat-openbsd, curl, openssh
BuildRequires:	unzip

%description
Sync a dynamic public IP address of a GNU/Linux server with the hostname in a your SSH config, via Dropbox.


%prep
%autosetup


%build


%install
%{__make} DESTDIR=$RPM_BUILD_ROOT install


%files
%license LICENSE
%doc README.md
%config /etc/%{name}/%{name}-blank.conf
%config /etc/%{name}/%{name}-settings.conf
%config /usr/lib/systemd/system/%{name}.service
%dir /etc/%{name}
%dir /etc/%{name}/units
%dir /usr/lib/systemd/system/
/usr/bin/%{name}
/usr/share/bash-completion/completions/%{name}


%postinst


%preun
/usr/bin/systemctl daemon-reload > /dev/null
/usr/bin/systemctl %{name}.service > /dev/null


%changelog
* Fri May 25 2018 caleb
- Init to RPM


