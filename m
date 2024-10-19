Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B38513C816
	for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729375694; cv=none; b=pLHoFUaKh0b3ovQZxCsYW6U+NMkjdma0HWjeqHIDgqpCbsHN8WARvAVir+GgyY7A1gc11RUMTQfDtcQawVgYq1kJQ055NPPY/hiHundKAnvqkhHPMw1S/IbrQmkeROOsOK0A9rlJQZyESkGsXHeiqq5BTCz4+vEI+Sjd3ruAmlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729375694; c=relaxed/simple;
	bh=M1x2hQaT8HoZW60oHKpchKlKkd2F4RFedo9SMP+a+0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fo5Hb7ClTOYT1zKDq12ott5yfU3K4wYqBNgdYWRMJR8A2iVFWo1S25XUBYXv5Ff60+ofd8hBp+qSuMEOKDKVwBqxlYs6ZXLOCieZAsvgSUmW6/r81jNBvfuKDr4AOIlvwZ73ux5HMDNXBt5/gMZyNwTsBX1hudDZnwjak+e/K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoNA+7dD; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoNA+7dD"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f58c68c5so5008155e87.3
        for <linux-modules@vger.kernel.org>; Sat, 19 Oct 2024 15:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729375690; x=1729980490; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GWz1Iheikdr80uqgQS9bSk6TLWrZfAHOzn5ybt1NF7A=;
        b=hoNA+7dDpHxcP0NnyNZBWf6pzw6hspzp36uWTw65O6LVfWSjnQM0tr3eFlW3dgbXGu
         VfTMiNvX8yP8dKfIwY1kmFee3zfk2pz7m82zPbah+yRYesJsFTduMCe6eq+a43drOni0
         v1h7NOeTKT2386I2YENi9MtSmjfc4Tgxmg/AOCjieSy9Zc675IKxq4lKhTw3rQScwrAg
         qfmqsZMyeK1wxgxELCGrh3gFzwAox2gG9CbTybYTcN3M5ATwTOpDD3HV8VT2Lqy2PTfs
         Fzz9Cf6pfahSAIPLU2Jcl47xXEcP46C6cViUkhf6RxTZmEFzWIPsgDHXBlOwKwCIh3HP
         d2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729375690; x=1729980490;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWz1Iheikdr80uqgQS9bSk6TLWrZfAHOzn5ybt1NF7A=;
        b=JM57wexnC07OgovpYKu49+2E9zfDQ/Kh6mIROgJ3HVeLe+jjd0cEZLuykqc28MhCpH
         EUyuvY+XkQRRJWhSDXQUoAVNjoaEgQPpV8FMfOuAs2slPs/CzP/JMIjC0TSNI1pzqiRX
         bWGcu4D3oRdLWas4Lm4nSXVWcXdcjwsJGfJjbfK8TyHrIkoCyRI0c6XsbPH/NA38mMpJ
         /N7Ek21vhwW3sJfX/QeVticc2XNqMY3trAXfrQzmLi0DMScCDMULwSGmfyaokqlIPer5
         uobB9Pi4LcKLgXK8j8pJjuS7iav3mIpQLKCe2UgGbavc9MFfYNeFUUuJWteKUXmuWes1
         pjEA==
X-Forwarded-Encrypted: i=1; AJvYcCViEDiUwAHplvhW4i2nhNY+4MhmiVvMHtxtJn1tmloKXUWWohMEkJdEZFs4wKtm8ODOhul6DdGfubLtOGKI@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Sc1kywMFPxV4e0u5SBq6vNYxWWUDSox/ubXHQM/rN0X+GLKf
	ZF8ylEkX3a9BiidEGc9LQzqBdAjWY60UNOHGTRZUVc2V86lRXI4RjbZwjjaQwhVzVHC533YxSfQ
	0Jq9s6jj5vfNNs+YrUs1tSbKtHcjUdvoQFOY=
X-Google-Smtp-Source: AGHT+IHui+pNMNrFlRkQ3p0LjHd1mBTsxlByvcXp+O9f3MjobL0GzfNq6pjmqvhGQW1TroewH0w/OkuPNfy/6qDMQPk=
X-Received: by 2002:a05:6512:308d:b0:538:96ce:f2ed with SMTP id
 2adb3069b0e04-53a1534086bmr5643068e87.10.1729375689830; Sat, 19 Oct 2024
 15:08:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+icZUULLhDyScuQnM4Tx+JD9xMFhnKVkxepUK_o1jGhJGo+bQ@mail.gmail.com>
 <CA+icZUW_K-f-ATDuvtsjXokx7aWUcfh7XpW2JhxBeegXp3V4xw@mail.gmail.com>
 <CACvgo50-oorSp+70CctrxQRt04T5bkrO-z4uX66GeBFXROxYZA@mail.gmail.com>
 <CA+icZUVi8_17bPgGYFph-Jc3bhTRRVZa1K8dJgOChHors_ySFA@mail.gmail.com> <CACvgo50dFQHROV+JhJOgutDOTYQg4R9aWTJdBXXhNWjR_rF9Bw@mail.gmail.com>
In-Reply-To: <CACvgo50dFQHROV+JhJOgutDOTYQg4R9aWTJdBXXhNWjR_rF9Bw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Sun, 20 Oct 2024 00:07:33 +0200
Message-ID: <CA+icZUXt5iDqw43-vxCamYFpz0SpaiWNfgkj8e+a5LwK9E5n+A@mail.gmail.com>
Subject: Re: First experiments with kmod-git and meson build-system
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: "Marco d'Itri" <md@linux.it>, Lucas De Marchi <lucas.de.marchi@gmail.com>, 
	linux-modules@vger.kernel.org, Tobias Stoeckmann <tobias@stoeckmann.org>
Content-Type: multipart/mixed; boundary="000000000000ad1abf0624dba773"

--000000000000ad1abf0624dba773
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 4:31=E2=80=AFPM Emil Velikov <emil.l.velikov@gmail.=
com> wrote:
...
> > [built-in options]
> > -buildtype =3D 'debugoptimized'
> > +;buildtype =3D 'debugoptimized'
> >
> > ^^ What buildtype other than above exists?
> >
>
> Check the meson website - it describes them quite well [2]
>
> [2] https://mesonbuild.com/Builtin-options.html#details-for-buildtype
>
> -Emil
>

Thanks.

In my custom INI file:

[built-in options]
buildtype =3D 'release'

and:

sudo meson install --strip -C ../build

Results:

# file /bin/kmod /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0
/bin/kmod:                                  ELF 64-bit LSB pie
executable, x86-64, version 1 (SYSV), dynamically linked, interpreter
/lib64/ld-linux-x86-64.so.2, Build
ID[sha1]=3Def45146171c0036544a9345fbd7d0c96e3fa4cc3, for GNU/Linux 3.2.0, s=
tripped
/usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0: ELF 64-bit LSB shared
object, x86-64, version 1 (SYSV), dynamically linked,
BuildID[sha1]=3D725a4446b481b380588011e4e8733c1db
eed3c82, stripped

# ll /bin/kmod /usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0
-rwxr-xr-x 1 root root 172K 19. Okt 23:51 /bin/kmod
-rwxr-xr-x 1 root root 103K 19. Okt 23:51
/usr/lib/x86_64-linux-gnu/libkmod.so.2.5.0

Best regards,
-Sedat-

--000000000000ad1abf0624dba773
Content-Type: text/plain; charset="US-ASCII"; name="howto-build-kmod-from-git.txt"
Content-Disposition: attachment; filename="howto-build-kmod-from-git.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_m2gpkd8f0>
X-Attachment-Id: f_m2gpkd8f0

WyBQUkVSRVFTIF0KCmFwdC1nZXQgdXBkYXRlCgojIG1hbi1wYWdlcwphcHQtZ2V0IGluc3RhbGwg
LXQgdW5zdGFibGUgc2Nkb2MgLXMKYXB0LWdldCBpbnN0YWxsIC10IHVuc3RhYmxlIHNjZG9jIC15
CgojIGRvY3MKIyNhcHQtZ2V0IGluc3RhbGwgLXQgdW5zdGFibGUgZ3RrLWRvYy10b29scyAtcwoj
I2FwdC1nZXQgaW5zdGFsbCAtdCB1bnN0YWJsZSBndGstZG9jLXRvb2xzIC15CgoKWyBCQVNFLURJ
UiBdCgpCQVNFX0RJUj0iJEhPTUUvc3JjL2ttb2QiCgpta2RpciAkQkFTRV9ESVIKClsgS01PRCBH
SVQgXQoKY2QgJEJBU0VfRElSCgpnaXQgY2xvbmUgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS91dGlscy9rZXJuZWwva21vZC9rbW9kLmdpdCBnaXQKClsgYnVpbGQtZGlsZWtzLmluaSBdCgo7
IFNQRFgtRmlsZUNvcHlyaWdodFRleHQ6IDIwMjQgRW1pbCBWZWxpa292IDxlbWlsLmwudmVsaWtv
dkBnbWFpbC5jb20+CjsgU1BEWC1GaWxlQ29weXJpZ2h0VGV4dDogMjAyNCBMdWNhcyBEZSBNYXJj
aGkgPGx1Y2FzLmRlLm1hcmNoaUBnbWFpbC5jb20+CjsKOyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjogTEdQTC0yLjEtb3ItbGF0ZXIKCltwcm9qZWN0IG9wdGlvbnNdCmJ1aWxkLXRlc3RzID0gZmFs
c2UKZGVidWctbWVzc2FnZXMgPSBmYWxzZQpkb2NzID0gZmFsc2UKenN0ZCA9ICdlbmFibGVkJwp4
eiA9ICdlbmFibGVkJwp6bGliID0gJ2VuYWJsZWQnCm9wZW5zc2wgPSAnZW5hYmxlZCcKd2Vycm9y
ID0gdHJ1ZQo7Yl9zYW5pdGl6ZSA9ICdhZGRyZXNzLHVuZGVmaW5lZCcKCltidWlsdC1pbiBvcHRp
b25zXQpidWlsZHR5cGUgPSAncmVsZWFzZScKLSBFT0YgLQoKTk9URTogYnVpbGQtdGVzdHMgb3B0
aW9uIHJlcXVpcmVzIGxpbnV4LWhlYWRlcnMgcGFja2FnZShzKSB0byBiZSBpbnN0YWxsZWQhCgpb
IEJVSUxELURJUiBdCiAKY2QgJEJBU0VfRElSCgpta2RpciBidWlsZCAKClsgQ09ORklHVVJFIF0K
CmNkIGdpdAoKbWVzb24gc2V0dXAgLS1uYXRpdmUtZmlsZSBidWlsZC1kaWxla3MuaW5pIC4uL2J1
aWxkCgpbIEJVSUxEIF0KCm1lc29uIGNvbXBpbGUgLUMgLi4vYnVpbGQKClsgSU5TVEFMTCBdCgpz
dWRvIG1lc29uIGluc3RhbGwgLS1zdHJpcCAtQyAuLi9idWlsZAoKCi1kaWxla3MgLy8gMTktT2N0
LTIwMjQ6IFVwZGF0ZSB0byBrbW9kLXYzMy0zMTQtZzU1N2U3OWMzNjBhMzsgVXNlIGJ1aWxkdHlw
ZSA9ICdyZWxlYXNlJyBhbmQgYWRkICctLXN0cmlwJyB0byBpbnN0YWxsCi1kaWxla3MgLy8gMTgt
T2N0LTIwMjQ6IEluaXRpYWwgcmVsZWFzZQo=
--000000000000ad1abf0624dba773--
