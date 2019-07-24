Name: nginx		
Version: 1.12.2	
Release: 1.0
Summary: WEB SERVER	


License: GPL	
URL: nginx.org		
Source0: nginx-1.12.2.tar.gz	

#BuildRequires:	
#Requires:	

%description

%post
useradd nginx
%prep
%setup -q


%build
./configure --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module
make %{?_smp_mflags}
%install
make  install DESTDIR=%{buildroot}
mkdir -p %{buildroot}/usr/lib/systemd/system
cp %{_sysconfdir}/nginx.service %{buildroot}/usr/lib/systemd/system/
%files
%doc
/usr/local/nginx/*
/usr/lib/systemd/system/nginx.service

%changelog

