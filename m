Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795457748;
	b=FnEqOHZK0n+khCxF8IU/EG0GuCXFzBGVSQUCezvaaARqghLDaxb+r9Vt0Sxu18Bp4Ski
	 vGWcBlCusM9JMkKvaVSKkYGU+e9tzWJIhHbACsJVZt7N9wTfo/ewVv65TLlhajoyjnZ+F
	 2VMAjLrLV1Hyv1O3PoRlL9UBj/3V8Sd3cMpYLt9pwMAQnGs/NMKxZSBQ3axHT6e/ik+qe
	 WCkmr1ceQUmSm6/Wj7IC2F1U0CyarGS5t9kOIm+A2GU18X2Jz1zOUY0mXsWWQtd6hMq0r
	 v12o8nGxwCIphPBLlmgplI5E3DmfhDGbphhloTyZ+Ub8UnHBgQu/baMXght8FGb+KmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
	b=Wj+c8SM9RfKCHD2CfnyluYod1+nhlAhX0flhpYINHe1eQoVFxC23PjRwJIhmkizssC5Q
	 tXgmprBp2fNlTH+PcqZq0HA92AQVGVmGF01kslWdP6pGBrdBCKapRo1le3a4X9eEqwUz1
	 yOXB/tX+hCxgwMDvZdDqW1VzdN1qOycU9RQAciIDIGaALunxjoKpI2l49ndugOBRN33VD
	 RDrVnGJ+PN+8/wvRAzW6n6UDI71pca4V/872t3w7JD7bisWsjz674+JyMtYo9gmz+jOMQ
	 JFUZhyzYcRL6IvYiGs6FligD5Yq8iMmSj5s4b4/F2KxdgMDkDjHGvlnAVcriQmmVzBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAvQ0XWo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FFA606A31A
	for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 18:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2FFA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QAvQ0XWo
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b4eab91bcaso19426217b3.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Nov 2026 10:15:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795457747; cv=none;
        d=google.com; s=arc-20260327;
        b=gfjgjrU8L5KW7qBFVBOCyCUWnaVeJMo4DzET87cXYeO2UG7WYLizmNzqMmYUwhXcS4
         h8UkiPdgE1WxYruwbeg2eoJxJwCqVYnN3kl6OdXQ+8nUEBOp7VR+aF/m8dmz6NELHUus
         hy1O982RlC5CwKaYR/Uxd9Px+jY7PdCY1nkhV8mhFGqU37DFvhONR9DDtjMg2kz6Z+Vr
         Q9nMvYsU2shYyYp+rZGSgKEpEeUks8+Iywtd0OHggkf9HWzgMorqtfyWE0YO+95i34lT
         NdDEPEBQ0yXgfUF24/aoxxRPxXheW5M2l41GhnHDa5WsSwD83w2YG0t6P+I/Wn4kx3BB
         GL1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
        fh=7xSH+MjWaHCyIWmGi7Zu8TACPGhCN7HSn42ChGPyNPw=;
        b=Q3Uxh5DONmkkWhniQVvmOllposMoesYdEgrWeih3CzMQLlZ9Zhnn+whbMiYmjP1LLv
         GIUWFupBQujz5VYdEmeeTo78ViC7G98J1BVHTYL2tzhPm2goVm3RGTGqRNWXFIgOKIOY
         t4nDFL4o1r+CQ6ptuJAgETyeWsVJ3Aa+kdOnogPcYJi2gzxRt84M/rwYRmbaBGBlgNSb
         h9VxGguktlSHNzg8dW0J9eHH6TV+pJ8XEjMi4MY2Q9O1UL3dsizktQKrF3cPKhcVpvvR
         /6yUE2TJbYFy4YP5RYte8eVjU9UH/6QSc2I8/IsZ8cd5kZ7tjVZrBPfQYRGnfmkeuWUt
         Ru7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795457747; x=1796062547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
        b=QAvQ0XWo0tcExbNOFzJESQZNbHYBLhpD32HKNvni4HEhtOqZEL5GCt+suncaWlBUiO
         FZtlYyNOqn9GHma1eRgPcYdd0NoljW9zR1Rc3Q6xInR6kvJqQNoPNRRrvYNNLbRwErFT
         C5Xb2wcOQSFScBdI2yQWvbeXEHGwhJMNY699xitU3dlCIUs7wu1tGJEo+Yar4GHnXN0U
         wLc//ydgb6yiwdJhE/yc8kHeO5YrOdlZnMqS9IH1XC7S+sN200e2Re8+RSKxq2UlZI6C
         C4TtJme+P2FM5uP3jC74YS73mzHG34FPYNDILJ0QBlMq6nWOwr9hYQ0pZ6Zj3bui1vtz
         H+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795457747; x=1796062547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMsBK5JZkeseYTz3X1TgvJ2SrDeEmSZ7YqTTt41Yzdk=;
        b=0jqOweakU3Jq4dYVaQNnH3uFR9QiPloUoQVYGphQ3TRcfSOxmO8BKrsppA0xj0vX+U
         YqCMb9dzy53Vfdn7LDNGd8PAIBj4rDwDAHb07b6gdqF45O/0K0tnWn2lMzkCW5ng9X8E
         Ifo5pNNeXfsv4kVEoX6gbRwbSgs/VGpY0O4XmTxYlDxtGUF0RHc8zB2gG8sciaAdf7JN
         +SIQGkk/pjUSLXcGyeRSae6HAsAAQD1a+M2p2GkTC7H7qI5onCl7MGBBoaJKaRZuXbRP
         PJwnxjvxU63RQX0JScr0pfTHO8QrzyEF0KhTEuVj4miX5YFGHBFFPREzcXbAciL5/tpG
         4Ucg==
X-Forwarded-Encrypted: i=1; AL+hErG8oS83ta7eSMuaBvBzmX6DvkmOVDlmkhIlVr4oy4OGvu2LBPMjRWyrBngbeyLcRtun7XC5qybuxmkt0yKS@vger.kernel.org
X-Gm-Message-State: APuU4Z85bY6Zx5J20VuJ1v83KWtCktinOH9MkaJadHWlf1w96JYy1wVQ
	n2ZWbkpLBZrYu+6tBuhw+tOWWjNUT++dTnQ4RwFOuSfYPzCJ+pnOVPEzf7rE0oHdozDOLVxHqQR
	t4EkS9dowALezSrmDyvJeIaiYxDW7d24=
X-Gm-Gg: AZFdTZccyhw/cKvIz/P2l8OHZ7OnjjB70AbfTVXLu3SxbqEl4pbdB6/47YolK7BaIug
	z+eo8XWpVyYSutxC+7/Ia1fzaYNtzZaBUq0o/S/YkBE45naCf914uKqn13HdUOTqVl0M9AKnrvO
	hRet96yQlvO0uyaMc2cKKbXXMKSt8MRva2F8za2WRynoPWUvW0J3T1DHrucnHLhASHr93KeTS5q
	+/gWZPX6J1NCSA621Wgr+YhXUmTriHbCxKDySK3iAGymXS6xII2cV/UcD5gTWmyY45SZJbvGvn/
	BmpT2+jk5vEL/mDI9PMcqrYQRl4/SfI/EeFLwkCvzpLpkv3Yx/TgEhR9g8XZiLhhvw7Dw/OVcMi
	YoNKlXifiH2mWp4+MqBCswoIFKSgsfq+47zDUdxr6fLw7Df7LKvwdwRPC7/NHcfgtohNy/wa3PK
	G4yS2GruwK0Cw+24k=
X-Received: by 2002:a05:690c:797:b0:8ae:87e7:9ab8 with SMTP id
 00721157ae682-8b5205437abmr48277337b3.67.1795457746844; Mon, 23 Nov 2026
 10:15:46 -0800 (PST)
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-vmlinux-lds-v1-0-49818f3f5cc0@gmail.com>
 <20261121-vmlinux-lds-v1-6-49818f3f5cc0@gmail.com> <a6fdcd6d4bce5ace3b4e34d1393f5cfe58e17c0d.camel@perches.com>
In-Reply-To: <a6fdcd6d4bce5ace3b4e34d1393f5cfe58e17c0d.camel@perches.com>
From: jim.cromie@gmail.com
Date: Mon, 23 Nov 2026 11:15:20 -0700
X-Gm-Features: Aa3M54oFOAYf6UTkbI4OQkVdZIf4cCrnHVvp22FVwZTxOnodSxK6PbkkLux5L8g
Message-ID: <CAJfuBxxJMwrBKTrwC8RoLKRs7uBBPrgfWmPom_r49JmnOPvMvQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] checkpatch.pl: generalize linker script macro exceptions
To: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jason Baron <jbaron@akamai.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 7:27=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Sat, 2026-11-21 at 15:49 -0700, Jim Cromie via B4 Relay wrote:
> > From: Jim Cromie <jim.cromie@gmail.com>
> >
> > checkpatch skips macro-rule checks in linker scripts; 3 of them
> > explicitly check for vmlinux.lds.h, and 1 (the 1st) skips on any
> > *.lds.h.  Generalize the 3 to match the 1st, including the escapes on
> > the dots, so they're literal checks for '.'
>
> Please remember to email the checkpatch maintainer too.

ack.
I missed that b4 prep -c didnt add you.

>
> >
> > Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> > ---
> >  scripts/checkpatch.pl | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index b8b64f720191..318e1f2577fd 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -6016,7 +6016,7 @@ sub process {
> >  # Usually multi-statement macros should be enclosed in a do {} while
> >  # (0) loop.  Grab the first statement and ensure its the whole macro
> >  # if its not enclosed in a known good container
> > -             if ($realfile !~ m@/vmlinux.lds.h$@ &&
> > +             if ($realfile !~ m@/\.lds\.h$@ &&
>
> Probably better to have something like
> my $is_linker_file =3D '\.lds\.h$';
> or maybe
> my $is_linker_file =3D '\Q.lds.h\E$';
>
> and use that everywhere

yup.

>
> > @@ -6175,7 +6175,7 @@ sub process {
> >
> >  # check for line continuations outside of #defines, preprocessor #, an=
d asm
> >
> > -             } elsif ($realfile =3D~ m@/vmlinux.lds.h$@) {
> > +             } elsif ($realfile =3D~ m@/\.lds\.h$@) {
>
> >                   $line =3D~ s/(\w+)/$maybe_linker_symbol{$1}++/ge;
> >                   #print "REAL: $realfile\nln: $line\nkeys:", sort keys=
 %maybe_linker_symbol;
> >               } else {
> > @@ -6192,7 +6192,7 @@ sub process {
> >  # single-statement macros do not need to be enclosed in do while (0) l=
oop,
> >  # macro should not end with a semicolon
> >               if ($perl_version_ok &&
> > -                 $realfile !~ m@/vmlinux.lds.h$@ &&
> > +                 $realfile !~ m@/\.lds\.h$@ &&
> >                   $line =3D~ /^.\s*\#\s*define\s+$Ident(\()?/) {
> >                       my $ln =3D $linenr;
> >                       my $cnt =3D $realcnt;
