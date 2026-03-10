Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EB92FFF90
	for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773150593; cv=pass; b=OX9wXqufy6BbKYoJ6NhRMiUFz/h4GETwmk6BGhyscaDQ568P+GOvxw4NJ3RWWHjze+BYuxuVFY8QULU7KVgE6TuZ0IVR3EiDnN7CA/d1IiMA17LLHCkz/QgHV3u6U07M8k7U0BEc9GLWnXhTnepkiM8HXTDI1nc2jaKIKyCZA+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773150593; c=relaxed/simple;
	bh=cke0iWNjC9FGJkXPt1DwmcKNAsGD7TuhD05sI+e5Ot4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rWAWodYmWilCCim2eoer5gZCnbLiCayJ63TG03aiigzm44yiV78D3KUCtIReSp/wxpli2g5tHcXAg5rouptw3uAvT7601qcso0RwPtL3EASnAz4VXJJdrnPGTYnqCtZCa5vRh6V9GLnF9L0jXOVzRxfEIn89yjjBzU7rlVtlFQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdE8aaAK; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdE8aaAK"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7982c3b7dfcso131219307b3.0
        for <linux-modules@vger.kernel.org>; Tue, 10 Mar 2026 06:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773150591; cv=none;
        d=google.com; s=arc-20240605;
        b=UE46Ojmlnl+uAC4Lr7hTXmCMrmZuROxnZ0HJ6xSXJ/CXV6Dhuohcbwpc5hb4rTj8O7
         o1YPdRvE6Gj2pGyZbKB+yhTzZFuJAw2ySdE8iNi67dObqvDVLLQXIuKe0NOuxkm445H9
         kytNbIFHxL+BZX0JGY9EcgQDSH6GaYgJMK83pqSW7Pfeben/8I78t7KGwQ1XYO3cPxwq
         zfz0sEtBijCvGc/me+CpkuHrP/MUgwWvyYPUOO6jRbAzxDkhYj7f19q/s4XpGwCYQXrG
         ezVrUNX58vSYpLbQz28WAw2CudBkkjjYXhETXzKsB5T1ujvlFcJJKPql33OWNi4O8KI/
         yfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j0zycgx/8X64idQhYAv2xcJ067bqdtcHIUEWEUbidDg=;
        fh=CuUwWngeye//TvPeTmPpEfFk5zUm3UQ1fMdermGAcfs=;
        b=N+nNPwOtvOeBiYc9LI5Nl0cv/+l3sxmaq7zOadJKvFuHyAQJjUwdiJRXFrOx3EeY2p
         qCQum0e2V5mZdZyKYL3FsXk+a2gtpfQ3udcm1UcNmlqcf7/xKIBXVNlzdzY64SaKr28D
         LUtay24hn5m8eqo3fDA95ZNqhKWEbRkSX4k/liNTaVcQuho7AKTnfFXmtG6OEteenLRY
         yTDkxetbrSm9waeJSO/KmQB/mkJHjAdhirGUorcBIXkbeR1qPvO2DhCLEqAWYkNcxqOa
         pr9iRUgIjBS+w5z+jI6mcnFvpaTbTVgBrt6zxoPzCEYuNHn8LRVeMhBGjx/Ks7q9xfDs
         Kx6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773150591; x=1773755391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0zycgx/8X64idQhYAv2xcJ067bqdtcHIUEWEUbidDg=;
        b=BdE8aaAKHOu/uT+jtY0gbqtYzRr5YDYGvQJRPJUjkZiBFMKnYXloAgRbjAyxc0UX8/
         WdCTwXGBpryZBffVLcabVowfaDBOr2Ge3t8Rt9+zzIwNKeB1jzEjcGJfdV4WGtnmeFjO
         FNVNwnwlTMdT3AsD5dDEShixB70e6R7qtUIC/EJnGK1A9BMl5BNAdccKxU8Qk9Rv7wsL
         Ew+4+YfsP/0wVPFltlNN1iFKojObkdekuHCM4J9vYovzjFNV3R5MNRdXJeQKAjx28Oc8
         msksJAM8EH40EoEftWuo6K9wh+3DFZLKCGxmkQb35d5uXcTaVe2XbDtfzTPn+czD7CZu
         iHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773150591; x=1773755391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0zycgx/8X64idQhYAv2xcJ067bqdtcHIUEWEUbidDg=;
        b=HheUOULk/AVSND6h2UWkqUj//R8au67O43/YXxANArkry9G9DZ1xieSieoLC3MJFnP
         rQTtvI81S94k2fA3llrXNk4ai2hAwf3zVNe/xqJuusBbwiWyhJuZpUnYhuUHPze9kDyE
         BPIEmof1Ds+noSyDxVV356CkKQKUHmQ6MJjuH72+LBzaNlPb+TRpbdRZZwCxEbnw1YdT
         sVoI0z5QS47MmRLMbLm7zZb2JXOz8CYZGeOc4Hi822NFzuoGfXOXwr+WzB3CTiqDrehV
         xv0Kmy9Wu0IKvgYKmwVLapzWH8nSNFiOmvphrR2T5gTYDSg+3XzdteJZPIDAHBiKyvqt
         BG0g==
X-Forwarded-Encrypted: i=1; AJvYcCWNYRi8fSx7wIxqvuD8ws/BV5j80r4xuE3IfePsslat4bIXbJcl+o0/pCcLX/9e+8P0JZgM2cf1FvTtl/KU@vger.kernel.org
X-Gm-Message-State: AOJu0YzNV+BCx9To1sTBvqfgwmI+8fkGfOR/zMiDaBYq5PdsDWW8oik3
	/HCtmg0pQAA42aRpCw3ZGGeH+92NLRnC3r3IsyzNNZMQjKMaZZ5YK4Ig4IhiMlp1V6ParmVdSvQ
	xyecNDrJP5YWeLyeCBerjlET8QKqxXV4=
X-Gm-Gg: ATEYQzzF6nAJKd8+T9bDUsHC1pONFtP7SnH2PKq6FML2fcVEgJj1uDNY2N4o9Ps9DkK
	A1FmZEyQFLFFHsZM0sISAU3nhdGatJfFZAweDUSPwC0WN887/D9xaTAjjhnpE4GinYj839S5P9m
	CRQ8tQxnV9zNhb7Sp1TIMX9y4e8B2HgObm6HUOsrtthcrby72fVaffIR/YUedlFRhkLw7ftIUEp
	5pRg9nXxKGthSM4rrWgVUdTakKfRTRcijv/CrmiZEiByOPZjyToyX6YaQOKHckIObPS7MX1Cr9V
	3auFV2Zd
X-Received: by 2002:a05:690c:6305:b0:797:afeb:de62 with SMTP id
 00721157ae682-798dd6b5c38mr149255297b3.23.1773150591297; Tue, 10 Mar 2026
 06:49:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <abAXjc6OihRcdoAA@infradead.org> <CALOAHbA3g=UVavYgxJXH_5v0TYMLd6QKUTd=HDbD74Cp+9Kgvg@mail.gmail.com>
 <abAZSCbSEGUhTdUn@infradead.org> <CALOAHbBpAi_FM=odrNkGwXGj1d-ydn=cwURXkUGLawzOMUufuQ@mail.gmail.com>
 <abAa03DO9aLxWcwX@infradead.org> <CALOAHbBoX00_eDLq4X6vTrbdLG5X=9-07jW=Ba+Oa-QjtZX3MQ@mail.gmail.com>
 <abAdr6zqeqSNMJ8X@infradead.org> <CALOAHbCmxa0ptYTcq1EjRKMrzvFHCyyrv8CeEDYOhuuo7-QbOw@mail.gmail.com>
 <abAf5ZtiQGFoOQvT@infradead.org> <CALOAHbCg=nmwtoaMJj1KpeGqAXEuuAdnW+RCbe5KXxKKYGozzA@mail.gmail.com>
 <abAg7Wgq6N49pezT@infradead.org>
In-Reply-To: <abAg7Wgq6N49pezT@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 10 Mar 2026 21:49:15 +0800
X-Gm-Features: AaiRm5058W62Q6sYiifD6jxZGBdkqXzzBIu1DijiA_Wv0J7pCt954GAsO_oYFJY
Message-ID: <CALOAHbCHw+YKtJoERMXRr-KRnnGT77hx=MZCe6Nj4-vBZ4yYbQ@mail.gmail.com>
Subject: Re: [PATCH v3] module: print version for external modules in print_modules()
To: Christoph Hellwig <hch@infradead.org>
Cc: atomlin@atomlin.com, da.gomez@kernel.org, linux-modules@vger.kernel.org, 
	mcgrof@kernel.org, petr.pavlu@suse.com, samitolvanen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 9:47=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Tue, Mar 10, 2026 at 09:44:56PM +0800, Yafang Shao wrote:
> > On Tue, Mar 10, 2026 at 9:43=E2=80=AFPM Christoph Hellwig <hch@infradea=
d.org> wrote:
> > >
> > > On Tue, Mar 10, 2026 at 09:35:23PM +0800, Yafang Shao wrote:
> > > > > Why would that matter?  You don't get a wild card to do things ot=
herwise
> > > > > rejected because you contributed something before.
> > > >
> > > > Could you please explain why I am being characterized as a "leecher=
"?
> > >
> > > Because you're adding overhead to the kernel for your out of tree cod=
e,
> > > which only you and not the kernel project itself benefits from.
> >
> > Why do you believe the kernel project cannot benefit from them, given
> > that all module maintainers have acknowledged their value?
>
> Because by definition it does not benefit from making life for
> out of tree modules easier.  And I really don't get your whole
> call to authority here, it makes hard for me to take you serious.

I think we'll have to agree to disagree on this.
Ultimately, it's up to the module maintainers to decide whether to accept i=
t.

--=20
Regards
Yafang
