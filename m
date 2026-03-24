Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2264035C6
	for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364874; cv=pass; b=rZoXqlCubvxIQQYmrLoW4g53iLepz+fOCfld0KBedf/aDUO3fj6eOOirmus7n3Yp38EOUvx6WuttTA7IcDVYRMIbxMRRTql740WpqspZG2yEr676z67zdvyhFAW3Xo5dzjRhKXuWcUurW2Bs6w7SijLJPEMso0sU1LsrrV9Y+CI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364874; c=relaxed/simple;
	bh=1Z6JMNCHSGaxtIAix0aAtaZagu/pLyzUz7fEOf63FQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAETc51iRsAFet2AcXJMes2YcoXNEVPMvYimBQMfkhkFScf1TnJg85MpOhO7CNFldaAzPo4JvQphzu1fexbqKnDLpuFPEBwvxklWp8Q7t09MmVlgArRAaZrjNKbcjvuK2Y5L6lBr4TNLdYqsMdIh5sX8/0abNDIL8iSESho4m5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhE2htIX; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhE2htIX"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483487335c2so43334335e9.2
        for <linux-modules@vger.kernel.org>; Tue, 24 Mar 2026 08:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364871; cv=none;
        d=google.com; s=arc-20240605;
        b=ibnJA/hjlizEZgFmLXbqEZpSy+D8lueMdkSVlECrPEarr/mJ21OMzcBMEG1/UlyqFH
         Ks6b51TAvAuGk56Y9sNtZncPHsYnYZmeuOpDiN871I1KD/kxeh/2rTHY6fumRC7CPzPg
         SaKcDjZ+T1v/G796UdUk7t+xSdN2UhjBm6WRg4iRSfNpmdkmlhzaqqZjIVzCPKfSmkU8
         Papej0ZDKRKm/SgvcZinD1VwUJxkxDxy9mlq1oWS3F8vx7xpf2epC5ds8ffWuw/EglKE
         RB20F+uRyBj7EVsPyHnNQgo0hSw2OX4g5hd5DUnvc909GmfI2upwcSqt7/N0BBsGhQOf
         rPTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BskBfui7rapELmoLhcbRuH9sFyg4/N10zalNMto/sCg=;
        fh=5SnwfD2p7mVVsbhBjYIERfm5YjiBnjDcjq+gf36te/U=;
        b=ckn2PqWLFXYFW9jm57eLG8W1HLz9ePcGW+PkWWPWD/Y/LHjRmluKswbSPjwaieN7KI
         Ww6q3KaefMmn89zvhCKDhgqks2kHMqtlw1VpqJ9Ypv9/iwAPzuaBqImiHuYqSPN9XmCl
         Nalr7Wb5+WalAoK++GvZCWYCNrR7G570xGR7TO2ooM+wYq8W/+wr4cgUlO753QTG5fi9
         Tp7dZkvlkyl3RH8LCUITDfn5VDIU71QcFKj9VMGO4oc8kp3LhLmb9CYSdbgPP5rUxwfX
         Cjtp4ISi2OcDdTDYSxwNAzFx13YbVEzs9akHzo5XNO/8vWb+4OO77oOOLiJ4xyI9Uyb9
         Hf0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364871; x=1774969671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BskBfui7rapELmoLhcbRuH9sFyg4/N10zalNMto/sCg=;
        b=PhE2htIXEQo5bYFb7KluljetQMoLlA9n2RRoXwzblUDzswJ8bFRC6AM5DRa+GExEBN
         FZGpT0eVO+zwKmDBhjlBIH5iZc6Jbb4aGj+Rm40RMZ5qOlrDF+nEJ4+hkxlUhCT2xYZG
         67EJ4PzVn1dA/LNeZr73nxAkCCp4C1SiD5w29nFBlv8bZI2ZGHEUdjGdZzygTOR4Prpx
         09ESScw+O9kLOAdlDMApNQWbRFOXjzOBQQteLYK3DMmvaN1vEh7qejhC1P1QvjIGg8bf
         LO4zH2XZV/QtPOEBc0k+CTr3Te3THej35F3tYmzoP0O5O+sQbP9ywiMg+bCB8bJ4kEvi
         tpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364871; x=1774969671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BskBfui7rapELmoLhcbRuH9sFyg4/N10zalNMto/sCg=;
        b=cjq6rtvuOEKn5ROQDUQNk59S1hNdcfyHgqD3C/PpTq7TUDnSF4f1aRNLJAfZ74aVsJ
         kUEyhc06Ga1/LVqgZSbn2vY4LpPu0a1ne8vSw6rJuxQkJ5LbhaapJo0JDrcqMa1N3bCc
         9XWAzxrv1udhiyKAiqX4y/DAT7xmvcptpz0jCMqTb1bJSqdmn4qNMNnCzScOCOM29Gt6
         Dpue7PDeYZG/OA1CCeUTwAS+X2oXn6ll67HXQx0ZyIZIaxHurilqOT5FM9WgJx1ubcEO
         LvFgIi3G7P2lDQkrtC7yh2WErsc//qFhnEwXuV8aUWtDSYGkNug/ZhydtEwpSk5DpDPX
         AkLA==
X-Forwarded-Encrypted: i=1; AJvYcCUoNUxj2qSRrXXoWWV1/CMQToCbGX8OVZhNK1WheBtT38dpr8pHSLhFth6qwvUMNgcbB6tbUK6I3VjZ8SgW@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcRi4m3/GPllnPIYLstkHnw514mzmPgGpBoA3c7odAUmHDYdN
	nZjehVA6eBWkIECpwq++LLWLRj/+C9bSYbdo+WxQLNPGG4AfNzttLnLz4bNK6H4K2IkhQAQsu0t
	yQVHWqKK5DraKBcaH37wh7Hk0kGTgUCs=
X-Gm-Gg: ATEYQzza2OPOKN0S4pfm7NRAj9YjmVgarrYOCEpb+x3IqPq4eRFBbqo+uHjTa9HnbRe
	6OUqp6cfVhirS7ygdKDZv0qQOQx3reF8bvhhjXI1BJTZlfZS5I19koQGipIfYIU2crCjCYFZaga
	TQycrf5dVJ6yYBlYRKvuWbbZn+gaQ4jLxL/RWhMSF7il1gzrPKlO+3yJb7RxeXKO4AaRi6j1DeH
	UPfXd1Piq+9+Hqk1YoEFGzxwPND0sQw71zIDrgrrLh4FnqiRwC0vcscmfM3NnA6Z9lCgKNZj3Wp
	XpCXWr7VIoHYSl9X3wCpgcd6LtWUtFCRCEdT9Pzv22DRrU/Zv9e+FNGThilxEqfAb+WHcVBSRtf
	gZwZ0lt2fzNbGQdnP/afpG/ZoMw==
X-Received: by 2002:a05:600c:8489:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48715fc384dmr1835815e9.4.1774364871041; Tue, 24 Mar 2026
 08:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323164858.1939248-1-sashal@kernel.org> <20260323164858.1939248-3-sashal@kernel.org>
In-Reply-To: <20260323164858.1939248-3-sashal@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 08:07:39 -0700
X-Gm-Features: AQROBzBqtCVnV-aokcS_jfx2Rq64gl7691VsnwgJMvcALBoTl8K4Z3ivzRJzHjM
Message-ID: <CAADnVQ+oBm7Gj3KScFujGwVKc5d2sqcK3MWX5K6dTAjekYitSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kallsyms: add BTF-based deep parameter rendering in
 oops dumps
To: Sasha Levin <sashal@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Alexei Starovoitov <ast@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	David Gow <davidgow@google.com>, Kees Cook <kees@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Helge Deller <deller@gmx.de>, 
	Randy Dunlap <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Juergen Gross <jgross@suse.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-modules@vger.kernel.org, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 9:49=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> +static const char *extract_struct_name(const char *type_str, bool *is_un=
ion,
> +                                      char *name_buf, size_t bufsz)
> +{
> +       const char *p, *end;
> +
> +       *is_union =3D false;
> +
> +       /* Must end with " *" to be a pointer */
> +       end =3D type_str + strlen(type_str);
> +       if (end - type_str < 3 || end[-1] !=3D '*' || end[-2] !=3D ' ')
> +               return NULL;
> +
> +       if (!strncmp(type_str, "struct ", 7)) {
> +               p =3D type_str + 7;
> +       } else if (!strncmp(type_str, "union ", 6)) {
> +               p =3D type_str + 6;
> +               *is_union =3D true;
> +       } else {
> +               return NULL;
> +       }
> +
> +       /* Copy name up to the " *" */
> +       {
> +               size_t len =3D (end - 2) - p;
> +
> +               if (len =3D=3D 0 || len >=3D bufsz)
> +                       return NULL;
> +               memcpy(name_buf, p, len);
> +               name_buf[len] =3D '\0';
> +       }
> +
> +       return name_buf;


Nack. This is just awful.
You didn't even bother to reformat what claude spat out.
Which means you didn't think it through.
It prints something that looks plausible
which is the opposite of what kernel crash dump should be.
crash output should be accurate and not a guess work.
