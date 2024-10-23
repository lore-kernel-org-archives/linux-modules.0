Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080531F9A98
	for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718596; cv=none; b=bGOtVekxruoopIouaQLceQ5QzvZehRPMkh+d1QqnwD3Ftt+lb81JkHslB9wr2NyhqS6FbzAzkqg88ME/aZmpIiRqvzdUF0Xv1ZKJnf9FXfMGQI7k6EFdlg5aJJl7Q+F+D0QmZyBJAM04sTxWqbx1yoKQFUokvsJhmsW7u8Ho9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718596; c=relaxed/simple;
	bh=WYNQSW7ZshuMmZ9FKpC4DC822M6MEfL1IQavMwfLhBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsWg07T7ZaACVAjuFpN4ZJ46RyOBRDcuurHtJasbUJG0BxIOJ9VE09OGBFxRfuAJGxBKR8qfOW8KdIaD68CSpMem5vg429s784vNSc1QvjnvRIGWy7DhurRjKdgXH4hbOpyifX26Jjim0w3tizUNOA9cA/U4sqWRGQiEbAqynKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHkIosrk; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHkIosrk"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so225460e87.3
        for <linux-modules@vger.kernel.org>; Wed, 23 Oct 2024 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729718592; x=1730323392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9zaLkkolDvkfuocXEj3D2xOZmjUNjBBFqxTj2YVlRWQ=;
        b=AHkIosrk0kkzk30LacIJq1qoKdE8+tM3rY3L9tGpWZAExwobmcg8wTQdf8hg1RwlKP
         s4iabZ27lznpbCLGN9N1wuqnz4XYVOr5afx7Bw2JYzqN51GAgKn+bs/zgih4dbuE+SbP
         eqoFxPNk+KapOWqPYxRylQHw5aU2DpBn3AeV8heHOjAXzhyJD4vjkY55CrEwGXHpJ3+h
         JHnbYYWEbJbHQq5a7xDamWVmVoQWHJESY5GiUQXldMflCPxXVACjqHLwSBVs5X/OmOb5
         r368ZN+1W2i1EFR74K2/c3KuRwlPDx/Qraku4ke6MJIdkyX4ZtjucxLME1IuB3P7Qxmb
         9lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718592; x=1730323392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9zaLkkolDvkfuocXEj3D2xOZmjUNjBBFqxTj2YVlRWQ=;
        b=VcHobgcMQ8snWndYDcPV2l34Uzfp6RdDNDM+pVbVh+Ps1vtBtJMgJhFArDBmeUR+V1
         P1rHIceA/Mo1tq2Y1AYT1pZ8yKOLuphWuQ7W2zqmDJqRV8eWwG57Qni2KMHvM9zyDsH/
         10XcUhHFxQHa3Dx3MVBi8H5VVe/1phEFJoshko/+VfzxEj3RvtHier+nznPI+9K44qmi
         cERgYRgf3R0/TWhhUl+yYtroZb/MrLFgy/6NMxjMj2jtvdhGYl5OcNTdjFVMX5qAVKQ5
         rvHIDrJFAku1Zw2P244Pk6VQP/JIvI9ZU1iMQcBje0nAivLbibv0PhCqOLToPnyLidZw
         1vgw==
X-Gm-Message-State: AOJu0YyZlQmg5wv43XZeElfN95L8ETw9k+KbsTfTkqNGfLyY9xQfwFCh
	gTnji8jF5BjC5wtC3B934rlgXlXECIIgwDF3zorfDYhcfbKSDRq8L5aO/3tJMfEIAWg13tnRj7q
	5i9Ms0qK8QNVi4t5FVaNsLNEQkGZEa065pCU=
X-Google-Smtp-Source: AGHT+IF+6Ub/EY0/s/zEbl/M/eAJ8VU/K1/J0HgDkI3r0hEReYA7VilB9cdCYV8CovxK+4MaEV5XVO3/VPWDCQZpUjY=
X-Received: by 2002:a05:6512:1189:b0:533:3fc8:43ee with SMTP id
 2adb3069b0e04-53b1a3030f0mr2465494e87.13.1729718590320; Wed, 23 Oct 2024
 14:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUVTpf+XjDp=Mh0ghuk2tQwkgGd0OMUzK++RBSfhBk4+aQ@mail.gmail.com>
In-Reply-To: <CA+icZUVTpf+XjDp=Mh0ghuk2tQwkgGd0OMUzK++RBSfhBk4+aQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Wed, 23 Oct 2024 23:22:34 +0200
Message-ID: <CA+icZUVN8_53EJro8RPd9X-5PH+bM674pm8Abq61fC8XMr1Trw@mail.gmail.com>
Subject: Re: meson: always pass complete path to kmod-symlink.sh
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-modules@vger.kernel.org, lucas.de.marchi@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:07=E2=80=AFPM Sedat Dilek <sedat.dilek@gmail.com=
> wrote:
>
> Hi Emil,
>
> commit 844835cd9a4e5f08e1a3eefb4928c5d769264894 breaks when NO DESTDIR is=
 set:
>
> meson compile -C ../build
>
> meson setup --native-file build-dileks.ini ../build
>
> [ build-dileks.ini ]
> ; SPDX-FileCopyrightText: 2024 Emil Velikov <emil.l.velikov@gmail.com>
> ; SPDX-FileCopyrightText: 2024 Lucas De Marchi <lucas.de.marchi@gmail.com=
>
> ;
> ; SPDX-License-Identifier: LGPL-2.1-or-later
>
> [project options]
> build-tests =3D false
> debug-messages =3D false
> docs =3D false
> zstd =3D 'enabled'
> xz =3D 'enabled'
> zlib =3D 'enabled'
> openssl =3D 'enabled'
> werror =3D true
> strip =3D true
>
> [built-in options]
> buildtype =3D 'release'
> -EOF-
>
> sudo LC_ALL=3DC meson install -C ../build
> ...
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
> /home/dileks/src/kmod/git/scripts/kmod-symlink.sh: line 10: DESTDIR:
> unbound variable
> FAILED: install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
> failed with exit code 1.
>
> Works:
>
> sudo DESTDIR=3D/bin meson install -C ../build
> ...
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/insmod'
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/lsmod'
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/modinfo'
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/modprobe'
> Running custom install script
> '/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/rmmod'
>
> $ ll /bin/*mod
> -rwxr-xr-x 1 root root  67K 23. Okt 17:36 /bin/chmod
> lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/depmod -> kmod
> lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/insmod -> kmod
> -rwxr-xr-x 1 root root 172K 23. Okt 23:02 /bin/kmod
> lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/lsmod -> kmod
> lrwxrwxrwx 1 root root    4 20. Okt 00:19 /bin/rmmod -> kmod
>
> Set a default for DESTDIR (destdir)?
>
> Best regards,
> -Sedat-

Lucas have a fix for it:

$ git diff
diff --git a/scripts/kmod-symlink.sh b/scripts/kmod-symlink.sh
index 6511284a97a6..f825eef89a69 100755
--- a/scripts/kmod-symlink.sh
+++ b/scripts/kmod-symlink.sh
@@ -7,4 +7,6 @@ set -euo pipefail
 #
 # For context read through https://github.com/mesonbuild/meson/issues/9

+DESTDIR=3D${DESTDIR:-/}
+
 ln -sf kmod "$DESTDIR/$1"

*****

$ sudo meson install -C ../build
Dropping privileges to 'dileks' before running ninja...
ninja: Entering directory `/home/dileks/src/kmod/build'
ninja: no work to do.
Installing libkmod.so.2.5.0 to /usr/lib/x86_64-linux-gnu
Stripping target 'libkmod.so.2.5.0'.
Installing kmod to /usr/bin
Stripping target 'kmod'.
Installing man/depmod.d.5 to /usr/share/man/man5
Installing man/modprobe.d.5 to /usr/share/man/man5
Installing man/modules.dep.5 to /usr/share/man/man5
Installing man/depmod.8 to /usr/share/man/man8
Installing man/insmod.8 to /usr/share/man/man8
Installing man/kmod.8 to /usr/share/man/man8
Installing man/lsmod.8 to /usr/share/man/man8
Installing man/modinfo.8 to /usr/share/man/man8
Installing man/modprobe.8 to /usr/share/man/man8
Installing man/rmmod.8 to /usr/share/man/man8
Installing man/modules.dep.bin.5 to /usr/share/man/man5
Installing /home/dileks/src/kmod/git/libkmod/libkmod.h to /usr/include
Installing /home/dileks/src/kmod/git/shell-completion/bash/insmod to
/usr/share/bash-completion/completions
Installing /home/dileks/src/kmod/git/shell-completion/bash/lsmod to
/usr/share/bash-completion/completions
Installing /home/dileks/src/kmod/git/shell-completion/bash/rmmod to
/usr/share/bash-completion/completions
Installing /home/dileks/src/kmod/git/shell-completion/fish/insmod.fish
to /usr/share/fish/vendor_functions.d
Installing /home/dileks/src/kmod/git/shell-completion/fish/lsmod.fish
to /usr/share/fish/vendor_functions.d
Installing /home/dileks/src/kmod/git/shell-completion/fish/rmmod.fish
to /usr/share/fish/vendor_functions.d
Installing /home/dileks/src/kmod/git/shell-completion/zsh/_insmod to
/usr/share/zsh/site-functions
Installing /home/dileks/src/kmod/git/shell-completion/zsh/_lsmod to
/usr/share/zsh/site-functions
Installing /home/dileks/src/kmod/git/shell-completion/zsh/_rmmod to
/usr/share/zsh/site-functions
Installing /home/dileks/src/kmod/git/shell-completion/bash/kmod to
/usr/share/bash-completion/completions
Installing /home/dileks/src/kmod/build/meson-private/libkmod.pc to
/usr/lib/x86_64-linux-gnu/pkgconfig
Installing /home/dileks/src/kmod/build/meson-private/kmod.pc to
/usr/share/pkgconfig
Installing symlink pointing to libkmod.so.2.5.0 to
/usr/lib/x86_64-linux-gnu/libkmod.so.2
Installing symlink pointing to libkmod.so.2 to
/usr/lib/x86_64-linux-gnu/libkmod.so
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/depmod'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/insmod'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/lsmod'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/modinfo'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/modprobe'
Running custom install script
'/home/dileks/src/kmod/git/scripts/kmod-symlink.sh /usr/bin/rmmod'

BR,
-sed@-
