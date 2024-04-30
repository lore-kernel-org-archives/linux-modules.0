Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0D1181B9D
	for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501145; cv=none; b=q8MJPDkQ0gWxtP+qfDF2mCVPHmLn5i8jP2DaO4RJMTT4z6ZBy1niUWRYxtH8ttyqTN4LeMcOlF54WUav3fHcnVVycPC0UQRzulxYAbkfzKev8qhH48E/RIsug+qIlspfeDq/bX/5P+9AVOUBd12xOqxQ5wLpDYGQMZYJfinbyc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501145; c=relaxed/simple;
	bh=+y2nXVOZJqr/WE8YEmZh+aVsx2971dEsOeH+mj4zfOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZh7uP7NIOXJDHc3ZEDv4MX6RwIhzeP06v3sOxESTULglOXoIU4Kyf1wUeZub03iDbJFHAM5U7GJgoMdfX/DPB5mHp5gf7YDzEh0pLJPm0ykS1JPuGaki3Tgy2lE3DEcj/lbAidCoym5G6tG571aOe7GB/u5WD36INvs3JI5B+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itSdfaiO; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itSdfaiO"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-de462f3d992so6549651276.2
        for <linux-modules@vger.kernel.org>; Tue, 30 Apr 2024 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714501142; x=1715105942; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PMR9FeUsRpwi8bkqOG34Uqtf4KyHJdc4NOqwOgJBp9Q=;
        b=itSdfaiOM/vR1ybQ6qk890k1RJ8iS6tcwVl8CXBDYluEivhxCcX+3Y/dsPIVPINRyh
         g3SZIzosnQZtgk3wO/zxbyt+4ftEseSS8zjAezTJy99vb9WdB5ZKyE6V/FIcPz+B94JR
         PuO1Tzj+YoV5Rlsjl52wTO6Y4COpNM3xfTqQK1fgQndiTtarJoe9ZoPx/PqTHBfTBqGY
         zA310JWdVFGrp2w5n0XWaOkcE6r4/LD5mVVZxV+P+lZmu8Lk4Jers1sYOsMeeN0S8pAW
         BgSV6oXhUcLfqRzfvW9o935/8xh3Sw+7nqSV43RvwUkBhCEJBpSwpHIqicHSgHyyrHT9
         Q+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501142; x=1715105942;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PMR9FeUsRpwi8bkqOG34Uqtf4KyHJdc4NOqwOgJBp9Q=;
        b=QhGszKi03PfzNEFMKjf3hbvGeKWEN8JPud3dzMO/jqlG0+HwwqzaNgndquqi9ejZUR
         tQNmimQp4gdtDfBR0p3iMRNVAmXRxgu+rtG3ZAn3mbPdwNmcgoaylWbL/Su1Rh6zANoI
         DyQHF1fHFwdM95Ce17Cm5KAcC/E1Fovx5mOvZEn0SeZIWAuKG6BdLudVUUJ37WZtWQQU
         piFWLr9CewsBrypVkya+CfielevF0ozR6z25SCwTToHUr0KADBKiLz9Z6E0Ay++jVjKV
         AwyEKbtzLTcV0iR9CZTiN/eax5kWCW+nls9j25us55+Mf66u4r8rrJvvDQHR/UxY/l+y
         cSvQ==
X-Gm-Message-State: AOJu0YxLYkacxzEyvHaVrQ+ohVu0GgUslCo/D+VQUfC+U344KVt9YG9I
	mIj0epKWIWlegms/KEg6x58Mt26Kx7/4XJrqIuVIO0CYFUSUvT/lUFdoVG4x81XCBx56Olr/40s
	k26tlPFWl8B2BAYK3L6I5qvNbJd8Ttg==
X-Google-Smtp-Source: AGHT+IF0b1+XKNH2yCcC7p3YlWp3uNDU67M8lc1bMrwz8fFh/g0GJFrIOgShcHshtNB70KzNKuBemFN18d3gpfLYidk=
X-Received: by 2002:a25:a286:0:b0:de8:4cfb:a14e with SMTP id
 c6-20020a25a286000000b00de84cfba14emr350575ybi.46.1714501142424; Tue, 30 Apr
 2024 11:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217-autoconf-manpage-warns-v1-1-e1570cfc286e@gmail.com>
 <63an63knqvcxyxh5ejx64bsxgpooikbba5inrd2kzbxuhuuenc@nk644hvv5j2p>
 <CACvgo53NkaRHbgBkWbiDwSKfUXGRDqV48-zD_NyakjqxUjF8Yg@mail.gmail.com> <ngw3fdsrhrggciujgposlrimsoe5a4opbr6d32smr7ebx6gj6z@jxryfcashci4>
In-Reply-To: <ngw3fdsrhrggciujgposlrimsoe5a4opbr6d32smr7ebx6gj6z@jxryfcashci4>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 30 Apr 2024 19:18:50 +0100
Message-ID: <CACvgo52q_b7seTQ4yrC2FzL9t-xEBixZ7jNBdbg=kAhGGy3rGg@mail.gmail.com>
Subject: Re: [PATCH kmod] man: silence autoconf warnings
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Apr 2024 at 22:45, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Fri, Feb 23, 2024 at 11:05:24AM GMT, Emil Velikov wrote:
> >On Tue, 20 Feb 2024 at 21:56, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >>
> >> On Sat, Feb 17, 2024 at 04:01:26PM +0000, Emil Velikov via B4 Relay wrote:
> >> >From: Emil Velikov <emil.l.velikov@gmail.com>
> >> >
> >> >Currently we have a pattern rule, which effective states that two output
> >> >files are produced - %.5 and %.8. Although that's not the case in
> >> >practise, since each input xml will be generated to a single manual
> >> >page.
> >> >
> >> >Add the manpage section as part of the xml filename and tweak the
> >> >pattern (match) rule, accordingly.
> >> >
> >> >Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> >> >---
> >> >Noticed, while wondering if I should add sanitizer support to the
> >> >autoconf build.
> >> >
> >> >A few, random questions:
> >> > - are there any objections to adding sanitizers support?
> >>
> >> no
> >>
> >> > - would a meson.build be acceptable? Giving us sanitizers, coverage,
> >> >   scan-build, etc out of the box
> >>
> >> yes. A few years ago we converted to meson but I think a few things were
> >> not working properly and we never finished that. If you few like adding
> >> that for the next version, feel free to use that as base:
> >>
> >> https://github.com/falconindy/kmod.git meson
> >>
> >> > - writing xml is fiddly, would people be OK if we convert them to
> >> >   scdoc? here are some examples of the raw file [1] vs the man [2]
> >>
> >> first time I hear about scdoc. syntax seems simple, but I do wonder how
> >> common it is in distros compared to e.g. pandoc or other options to
> >> produce manpages.
> >>
> >> I know mkosi writes markdown and converts that to a manpage
> >> (https://github.com/systemd/mkosi) and dim uses rst2man
> >> (https://gitlab.freedesktop.org/drm/maintainer-tools.git)
> >>
> >> Any of those options seems better than writing xml, so I won't oppose to
> >> scdoc if it's available in multiple distros out of the box in a version
> >> that is sufficient for us.
> >>
> >
> >Neat, thanks for the input and pointers. Will do some digging and
> >provide a summary wrt scdoc/rst2man
>
> did you get a chance to try those? TIL igt also uses rst2man for its
> tools
> (https://gitlab.freedesktop.org/drm/igt-gpu-tools/-/tree/master/man?ref_type=heads)
>
> so I think it would be the preferred one.
>

I have been mostly AFK the last few months, so I didn't pick on this.

My main concern with rst2man is regarding the state of the python
ecosystem. Python 3.12 was released circa Oct 2023 and it landed in
Arch just this week.
From casual observations - hundreds of tools are not adhering to the
deprecation warnings and thus might be broken as python 3.13 comes
out.

Admittedly all that is somewhat tangential.

Will play around with both tools and provide something less hand-wavy
in the next few days.
-Emil
