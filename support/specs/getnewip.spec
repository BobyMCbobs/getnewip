Name:           getnewip
Version:        2.2.1
Release:        1%{?dist}
Summary:        Remote server IP to SSH config hostname manager
BuildArch:	noarch
License:        GPL-3.0
Group:		Productivity/Networking/System
URL:            https://gitlab.com/BobyMCbobs/%{name}
Source0:        https://gitlab.com/BobyMCbobs/%{name}/-/archive/%{version}/%{name}-%{version}.zip
%if %{defined suse_version}
Requires:       bash, netcat-openbsd, curl, openssh
%else
Requires:       bash, nc, curl, openssh-clients
%endif
BuildRequires:	unzip
BuildRequires:	systemd
%{?systemd_requires}


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
%dir /etc/%{name}
%dir /etc/%{name}/units
%dir /usr/lib/systemd/system/
/usr/lib/systemd/system/%{name}.service
/usr/bin/%{name}
/usr/share/bash-completion/completions/%{name}


%pre
%service_add_pre %{name}.service


%post
%service_add_post %{name}.service


%preun
%service_del_postun %{name}.service
%systemd_preun %{name}.service


%changelog
* Fri May 25 2018 caleb
- Init to RPM


