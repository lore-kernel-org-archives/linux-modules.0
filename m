Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7542418FDA3
	for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 11:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729337723; cv=none; b=C4KkD/nBR6EyP/skZ37rsTBM6Ag09mRM3sW6Op1MbQ6vn5rhi+D3BHdl89chLcVuqA4W8EWK4gIfC2koNABCuFlbGJjFEV/fTP/w6kEOLqjNldwBmHh8kjGFPEmZBMGvJMm2PMB6DcMhhMHFw/5ll/U50qfkLqXBQyGRY421o/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729337723; c=relaxed/simple;
	bh=2n4PF8CnprW7GUDooRd4Nz6EVnHgF6NYo3jxvhbdf5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HIJrzM8LFEsJqtaiU9yhAja4fwlgaxwhDN6tZw0uXRlqUz79S55yptbEycYBIL5wePWU3wkeRBjF381Bwc2OPLTBEv1LMKOjUFEqDVCgcgOJg4PHAqys4VXAGoTS0NJmGWPV8fS8/a/qxwHhS/Ay48lVHRGc5s+cN/+l1NR6qbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICFi6pNs; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICFi6pNs"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53a007743e7so3657192e87.1
        for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729337719; x=1729942519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I8w+UoMDInrXbiFCIfoc3+F1T0v0NGy1HmrrSz4kaCI=;
        b=ICFi6pNsqJKgyJ0XuBDTlN94CKoQQqY4w1hnTKX2dLpJ5R40yB8xzZotHqitHjhb5C
         hdq0UPuHHIcJqL6+6J9492PWplt1Zvd4+Shh6my4v0nw/FUUo1+5lbNgp3K5AdzFApXH
         Q0fNi4HLXAkFzxhE2AgG10oAgd/wcf3Re2kHtAAWN3kBEIYm4gppyQ3cDrYLc5sMulDJ
         kD0YADBRyRV24RegFTnljpdnO34xeasDSbZ6l830iqZ8PWNs29zw6eNxLCoVmlZoD06D
         iM7xa7FdpbFjovt6lySDGTfYF0JMUKKYT1TBPsWEMRFtI7xTRxL2EZIBoY4PFrjz/UsE
         IRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729337719; x=1729942519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I8w+UoMDInrXbiFCIfoc3+F1T0v0NGy1HmrrSz4kaCI=;
        b=SQ1r+TgxabdNyTaKXQYJweXQ/ZKQguczkxpG+/pWqxeXbwMe/1oyXfLuZR1E3oKu4H
         GlFF3zbnuMwj0qAbv9h0oBr/VN/LMX9H4078CI6JL29d7wWJ56d32V5tr25ppbEztzC+
         l8eOGwxdGhSl2xdbtx2sahEVHjaSmiZfhh9hbTyuFKmuqVHQu/VUbiPqqqEPbAEy2wZq
         DHIoneuAeruwiPP1aJskdqCYbu/ag3HfUv0uMDhCtG+OIssHDij0awD76qKxviHzWZsT
         FK4+g8gf3SlbGXnRRwK6sfkzSrPQXrWOWrfMaUNf4p7hNpxtNU104zfYhlb4FNY6XpgN
         zalw==
X-Forwarded-Encrypted: i=1; AJvYcCV3N0xksLfDh6bzNt8dTXs8dXcrKXbSLutyWkfRTw8Ioq/FwqGQW/ZEtTJlaZ+zbuje+005xTkMHYMz8q8K@vger.kernel.org
X-Gm-Message-State: AOJu0YyQAeiADHOhmAIHGCs0UXUVdvA67pXNyWAcrjUzH0oytnMQU9ob
	YBHsHtOr/MIpWftUNa6xgxN38XMXQDqzSSiDnmqb4bNxkHdY/e72N8+QoicrWQeCLOyKqcTx3GH
	bxbW+aDERQeKr7Jqy3iT6EJ/m85w=
X-Google-Smtp-Source: AGHT+IGk60pp13OWq6sWMeVGzSzbi2gc45nfxmHM9VetSrKDDZ4Fc7VgbqcoXI/tU5c/dK8GIWtnyOtMxpXnMKCoRuQ=
X-Received: by 2002:a05:6512:1293:b0:53a:bb9:b54a with SMTP id
 2adb3069b0e04-53a154fa5e9mr3002685e87.48.1729337719248; Sat, 19 Oct 2024
 04:35:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
 <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com> <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com>
In-Reply-To: <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sat, 19 Oct 2024 13:34:43 +0200
Message-ID: <CA+icZUVi8_17bPgGYFph-Jc3bhTRRVZa1K8dJgOChHors_ySFA@mail.gmail.com>
Subject: Re: First experiments with kmod-git and meson build-system
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Marco d'Itri" <md@linux.it>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	linux-modules@vger.kernel.org, Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 2:01=E2=80=AFPM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
>
> Hi Sedat,
>
> On Fri, 18 Oct 2024 at 11:48, Sedat Dilek <sedat.dilek@gmail.com> wrote:

> Have you tested the resulting files, or you're just building testing?
> In case of the latter we already have CI which covers Debian so
> :shrug:
>

Hi Emil,

Great, you consider Debian/unstable builds in your CI.
Thanks.

> > looks like etc directory was not copied to $PREFIX.
> >
>
> Yes, meson behaves differently wrt /etc - not much we can do there.
> Ideally you can check how other Debian packages using meson deal with
> this and borrow the approach.
>

Hmmm, can this be somehow documented - say in README.md?

> > meson setup --prefix $PREFIX --sysconfdir $PREFIX/etc --native-file
> > build-dev.ini ../build
> >
>
> The build-dev.ini is a configuration file for kmod _developers_, so it
> for packaging purposes seems off IMHO.
>

Yupp.
Did upgrade to latest kmod-git and moved to a custom ini file - see below.

[ Documentation ]

README.md requires some hints to manpages and docs build requirements:

manpages: scdoc
docs: gtk-doc-tools (/usr/bin/gtkdoc-scan)

Link: https://packages.debian.org/sid/all/gtk-doc-tools/filelist

I see some more improvements to README.md.
Offer: I can cook up a patch and send for review.

> If you want to help with the Debian side, you can reach out to their
> maintainer Marco (CC'd) via the debian bug tracker, email or salsa[1].
>
> HTH
> Emil
> [1] https://salsa.debian.org/md/kmod

Ah Marco :-)!

I did an install from kmod-git with overwriting the kmod binary and
libkmod library.

Renew my initrd.img file:

KVER=3D"6.12.0-rc3-1-amd64-clang19-kcfi" ; update-initramfs -c -k $KVER
-v 2>&1 | tee log_update-initramfs_$KVER.txt

Booted fine!

I saw some other things like:

 file /usr/lib/x86_64-linux-gnu/libkmod.so*
/usr/lib/x86_64-linux-gnu/libkmod.so:       symbolic link to libkmod.so.2
/usr/lib/x86_64-linux-gnu/libkmod.so.2:     symbolic link to libkmod.so.2.5=
.0
/usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0: ELF 64-bit LSB shared
object, x86-64, version 1 (SYSV), dynamically linked,
BuildID[sha1]=3D3990121244ac36f617b2d289712054ecb1e390ba, with
debug_info, not stripped

Or an ASAN complaint is displayed requiring a LD_PRELOAD when
"b_sanitize =3D 'address,undefined'" is used (when running
update-initramfs).

I have done my own INI file:

--- build-dev.ini       2024-10-19 13:24:58.806312629 +0200
+++ build-dileks.ini    2024-10-19 13:26:05.332670566 +0200
@@ -4,15 +4,15 @@
; SPDX-License-Identifier: LGPL-2.1-or-later

[project options]
-build-tests =3D true
-debug-messages =3D true
-docs =3D true
+build-tests =3D false
+debug-messages =3D false
+docs =3D false
zstd =3D 'enabled'
xz =3D 'enabled'
zlib =3D 'enabled'
openssl =3D 'enabled'
werror =3D true
-b_sanitize =3D 'address,undefined'
+;b_sanitize =3D 'address,undefined'

[built-in options]
-buildtype =3D 'debugoptimized'
+;buildtype =3D 'debugoptimized'

^^ What buildtype other than above exists?

Thanks for the helpful hints, Emil.

Best regards,
-Sedat-
