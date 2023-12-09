Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8205B17991
	for <linux-modules@vger.kernel.org>; Sat,  9 Dec 2023 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz8aZlmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13820C433C8;
	Sat,  9 Dec 2023 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702145882;
	bh=R5ZqTIsMDapndSl6oaBUH9DW8tz2s6A2Ngjnci39c9M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Gz8aZlmWCPHCAktMsTWG3XsRrJRWaPvTnsi7+zJljDjoHtnkLQQvVV6pwvZIsxhOd
	 A9UpkFMMgfNIxPo3QOeWe+PVRJQKPj7A+RKcbWO9ORNdUNf/sqIOf9J0oUoedDtbjU
	 2BedZ6ToDA7Po2yWRBEemNi16k8YYtw7c/cculnVrGJ2nK0mlpwM0pcDJBu6ReHVVE
	 1He84Ddf+eAgN7VWQgSCJDac2A03+E5QjjrOZIF1YOExCQOybPAlw5YF0Domt+jdwy
	 MsekoHzS1wsozVvGAql6o+9oVTfkfYiRnuiiQZP7QyhICWdTxZEmzvSSJT9zRWPBcZ
	 G6W99hF9OCsDg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6d9e2f04f32so1265496a34.1;
        Sat, 09 Dec 2023 10:18:01 -0800 (PST)
X-Gm-Message-State: AOJu0YymnBU/w6B6TVveWazqPDQuQ98YmxRPpQlpphUwfTnKUAdGP0In
	2wtW3K+mOouEnkqRjzrl6xBqdml7+9QRTu3vLm4=
X-Google-Smtp-Source: AGHT+IEaf0cKHdkciN6jW7bo3skMH9gHfZ3v/7RstDK4kzkOqUuL0iSzr982L2JW49q5sg9OEobLwe6S+bJEm/UztAQ=
X-Received: by 2002:a05:6358:1e:b0:170:2b33:d77e with SMTP id
 30-20020a056358001e00b001702b33d77emr524506rww.55.1702145880374; Sat, 09 Dec
 2023 10:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
In-Reply-To: <CAFSh4UwYYAOb0YpC=WAL6SD+8jTLuSkhgrgjh8JmogUb10V=zw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 10 Dec 2023 03:17:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASE6H2GoXzJ1PXWEqsemQ3ny1K34vOxN0uVn1fh7Mmt5A@mail.gmail.com>
Message-ID: <CAK7LNASE6H2GoXzJ1PXWEqsemQ3ny1K34vOxN0uVn1fh7Mmt5A@mail.gmail.com>
Subject: Re: Building signed debs
To: Tom Cook <tom.k.cook@gmail.com>, linux-modules <linux-modules@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 8:14=E2=80=AFPM Tom Cook <tom.k.cook@gmail.com> wrot=
e:
>
> I'm trying to build a signed .deb kernel package of
> https://github.com/torvalds/linux/tree/v6.6.  I've copied
> certs/default_x509.genkey to certs/x509.genkey.  The .config is the
> one from Ubuntu 23.10's default kernel with all new options accepted
> at their default and CONFIG_SYSTEM_TRUSTED_KEYS=3D"" and
> CONFIG_SYSTEM_REVOCATION_KEYS=3D"".
>
> This builds the kernel and modules, signs the modules, compresses the
> modules and then attempts to sign the modules again.  That fails,
> because the .ko module files are now .ko.zst files and the file it's
> trying to sign isn't there.  Full failure is pasted below.



Modules are signed before the compression.


Once you compress modules, you cannot re-sign them again unless
you decompress modules, sign them, and compress them again.


Now, the kernel can directly load compressed modules, so
perhaps allowing users to sign compressed modules might
be beneficial.
(that is, reverse the order of singing and compression)

I am not sure whether it is possible or not, though.


I added linux-modules ML.










>
> Unsetting CONFIG_MODULE_COMPRESS_ZSTD is a workaround (ie disable
> module compression).
>
> Is there a way to build a .deb of a signed kernel with compressed modules=
?
>
> Thanks for any help,
> Tom
>
>   INSTALL debian/linux-libc-dev/usr/include
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/even=
ts/amd/amd-uncore.ko
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/even=
ts/intel/intel-cstate.ko
> At main.c:298:
> - SSL error:FFFFFFFF80000002:system library::No such file or
> directory: ../crypto/bio/bss_file.c:67
> - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c=
:75
> sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/eve=
nts/amd/amd-uncore.ko
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/even=
ts/rapl.ko
> At main.c:298:
> - SSL error:FFFFFFFF80000002:system library::No such file or
> directory: ../crypto/bio/bss_file.c:67
> - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c=
:75
> sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/eve=
nts/intel/intel-cstate.ko
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kern=
el/cpu/mce/mce-inject.ko
> make[6]: *** [scripts/Makefile.modinst:137:
> debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/amd/amd=
-uncore.ko]
> Error 1
> make[6]: *** Waiting for unfinished jobs....
> make[6]: *** [scripts/Makefile.modinst:137:
> debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/intel/i=
ntel-cstate.ko]
> Error 1
>   SIGN    debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kern=
el/msr.ko
> At main.c:298:
> - SSL error:FFFFFFFF80000002:system library::No such file or
> directory: ../crypto/bio/bss_file.c:67
> - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c=
:75
> sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/eve=
nts/rapl.ko
> make[6]: *** [scripts/Makefile.modinst:137:
> debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/events/rapl.ko=
]
> Error 1
> At main.c:298:
> - SSL error:FFFFFFFF80000002:system library::No such file or
> directory: ../crypto/bio/bss_file.c:67
> - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c=
:75
> sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/ker=
nel/cpu/mce/mce-inject.ko
> make[6]: *** [scripts/Makefile.modinst:137:
> debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/cpu/mce=
/mce-inject.ko]
> Error 1
> At main.c:298:
> - SSL error:FFFFFFFF80000002:system library::No such file or
> directory: ../crypto/bio/bss_file.c:67
> - SSL error:10000080:BIO routines::no such file: ../crypto/bio/bss_file.c=
:75
> sign-file: debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/ker=
nel/msr.ko
> make[6]: *** [scripts/Makefile.modinst:137:
> debian/linux-image/lib/modules/6.6.0-local/kernel/arch/x86/kernel/msr.ko]
> Error 1
> make[5]: *** [Makefile:1821: modules_install] Error 2
> make[4]: *** [Makefile:2036: run-command] Error 2
> make[3]: *** [debian/rules:17: binary-arch] Error 2
> dpkg-buildpackage: error: make -f debian/rules binary subprocess
> returned exit status 2
> make[2]: *** [scripts/Makefile.package:146: bindeb-pkg] Error 2
> make[1]: *** [/home/tkcook/git/linux/v6.6/Makefile:1538: bindeb-pkg] Erro=
r 2
> make: *** [Makefile:234: __sub-make] Error 2



--=20
Best Regards
Masahiro Yamada
