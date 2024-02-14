Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6760EF9
	for <linux-modules@vger.kernel.org>; Wed, 14 Feb 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927779; cv=none; b=YIrF5dEtGEMWk/OlSMkqjkEfN6GSOn6qK+rxtJU51BGD28yCl9swp3wdD+dM9C7ckxeeN6uZBXrhl4afxUxpyKoaZ/OD04CryPQhpqPSLorBRlW89BGlbR4VYaWleK3oSG8eWogou32paPabbqRex8dy0IFO4fAVtYw3uPmJqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927779; c=relaxed/simple;
	bh=PbBE9hyrZXBLx5vaksEQqXlxr1hq4xJkJbClqT7prbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K98EDpgThc4DAJFaQuDYOpSfwXeNexcLHwkyJR5icsCMypYHWJun7f2ulibHBqjUfultPgwNGxTbKBoKZXH5O0NfmFxJnvV/dlyWZIxZq1SyFg4yj7JMkbSWxdzOocGGTQgKHoUhf30V9c/rVIE2zHEsxokXNQykRvB4AlTNo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBIeYp+q; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBIeYp+q"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso5881259276.3
        for <linux-modules@vger.kernel.org>; Wed, 14 Feb 2024 08:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707927776; x=1708532576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PfsNH2DDaSZJvv6w9txIObvnzb25cxCRn0oO3AVkfQ0=;
        b=mBIeYp+q4sXb28baKSCKs127dm6qQwVFlC6pd1ioGqWLikJgx8tzGLqpP6PCYep2/+
         PuBnbL8ZIDQ2RryZ3Aj2eqITctXb7LSVUSxgtg5AWn+3L++/tTYEMgB8TqlVByh2yUE3
         3LINSk54n0Ra1CooZaTuv+7OyV949UQXRaRROgDFEzMI7xr1V9UOG8vTYLymc9ObrTdd
         qa22bJqQgYfQYAmWZpv8zliidrrm9taI6bNAXTE0xnB4h/AssvOQSQ4F9LNztALKqejX
         Wwz5vaz8hPQIhoar+RSLmk4tFfZ3eZSMbDtxHl9zNVRA4r2EWYpfHePEZ1GwUSgAmbVK
         eflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707927776; x=1708532576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PfsNH2DDaSZJvv6w9txIObvnzb25cxCRn0oO3AVkfQ0=;
        b=rbLG60IfFkd7GCioMXTqLuLFUdI5rIcWU+rupLRSfW57E0hq9Zv1BDen3Rn8+oJz1Z
         7pO9RKiOpLiTAhNPialIkWI2mjhx7mcnCQGWqmvicALlzp+zxzeVLcRPJAsA1CNmCw2U
         wcxKV8YQoBq1cpo4hsC2JLGI0kdQdccv0r63t/jbuLPM+Xh/EbRlRfvNBgSGW1oXR/Bd
         5DFOFtdblmkqMPThxQoXjpxWmlhDa9Vv8m5kTO5CLtjXOXMkdP1d9x4uUKmhPNq2mJSH
         2R5j8OWlMrBd/ll/tQFbHoPbuWR7ruxnL+C/WAUaQv9nE5CAQsD7Z2h1FP9EI+O2G5U8
         W1HA==
X-Gm-Message-State: AOJu0YyzahSUG3waSLF29FMAEIUVfRzQ7btk+hc04CSiZBAJCtgpgm6d
	q9cMMg6uP+rFfdnpTvygG1n+SG03Yzp+mTNiLqYY2+o1mp0qxekFZhOceTpRfKmKm9xXSFU3fY4
	f9c/HmvuuazsCwEowgbkNTwccbIZJfmqy
X-Google-Smtp-Source: AGHT+IF5HI4XFh+8cY9WwWDHYILEOBBa0oPy7hgvF4B6kze8Nq6XWJIiZ6Y14gymuDQBLE0v1gTomEHaOo6P23mSbN8=
X-Received: by 2002:a25:ada8:0:b0:dc6:aebb:168e with SMTP id
 z40-20020a25ada8000000b00dc6aebb168emr2765861ybi.26.1707927776133; Wed, 14
 Feb 2024 08:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-master-v1-0-6257d039a30a@gmail.com> <20240126-master-v1-2-6257d039a30a@gmail.com>
 <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
 <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com>
 <72ijqdtswcehmfjgodgg6chauou4vjkyh6ieup7osrcxbfwvua@arh6o2k2yddl>
 <CACvgo50Y1=-+SxLMsHy-Nc66wt1=S7iwjthRU-UVeS_N7o-EGQ@mail.gmail.com> <4on5pkpsatbpp75qocejyrgxg5dzccu5sm43tmujccd2wd4cr7@2lercurz46f5>
In-Reply-To: <4on5pkpsatbpp75qocejyrgxg5dzccu5sm43tmujccd2wd4cr7@2lercurz46f5>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 16:22:44 +0000
Message-ID: <CACvgo53Y+JQA9A6VdwYyHiAvs8HPssotBbfmdPnPxG83Yq9Ztg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 16:15, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> On Mon, Feb 05, 2024 at 05:50:54PM +0000, Emil Velikov wrote:
> >On Mon, 5 Feb 2024 at 14:30, Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> >
> >[snip]
> >
> >> >I'm not a huge fan of using relative symlinks, especially if the tool> >is run as root. In my experience that makes things harder to audit and
> >> >prevent accidental breakages.
> >>
> >> I'm completely in the opposite camp. Relative symlinks actually make
> >> sure the thing you are running is what you are expecting. Nothing should
> >> really point outside of $prefix expecting that is mounted on /.
> >>
> >
> >That is true and I fully agree. Yet the contents of DESTDIR are not
> >meant to be run as-is - it's used for "staging" [1].
> >
> >[1] https://www.gnu.org/software/make/manual/html_node/DESTDIR.html
> >
> >> Several years back there was also the issue with packaging, which would
> >> complain when symlinks pointed outside what was being packaged.  It is
> >> dangerous when using absolute symlinks because if the tool used to copy
> >> follows the symlinks, it ends up with the wrong binary, copying the host
> >> bin rather than what was just built.
> >>
> >
> >That sounds like a horrible bug, which can easily break your system
> >regardless of the project.
> >
> >Would you consider dropping the leading `./` aka can we use `$(LN_S)
> >kmod $(DESTDIR)$(bindir)/$$tool;`?
> >Seems to be prevailing on my system with over 90% instances.
>
> seems good to me. I will squash that and push.
>

Respectful poke?

Thanks
Emil
