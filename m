Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95DE45946
	for <linux-modules@vger.kernel.org>; Mon,  5 Feb 2024 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155469; cv=none; b=Yc9x+YHM72TRO66LF97WONXEUXekRN51jMh3JahLY86FKOZOQCdeaRI8MuUYelFy+IznBg96w5tnmL7V5lzcTwK7pnGIFNjS9/Nh507wMPX6e5Q/5gF4dBxSHZNEHaZD07GO/Uq/ZlICbDE0U9kKPea9kG0tOEL88jRUGFCld40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155469; c=relaxed/simple;
	bh=cyWP7ExkYwgGeMSlII8DKd+myzbp3AN3Vp58foiYYpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LZFKod/cs+9r6SmzcnJ+A/OKBptZBUlZ1gtDjcMsNkoLbCXs71mdVxH/aLR3KuviOnVzlnwRMGXnKCufP5Az9BZp+CWKydp8xQoDKqmm2dhq2PZ+Z2wJHns/7WieWqBd+yfY5aVFYL53GK71M4CfefnRzn2WgFzNzcEm/kc7s2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7qju+jZ; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7qju+jZ"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6043d9726adso14368717b3.0
        for <linux-modules@vger.kernel.org>; Mon, 05 Feb 2024 09:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707155467; x=1707760267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t+3gsjZOPYy2xJyHlTt4CW96ozuzzW3lRR0ii8blzlI=;
        b=d7qju+jZGyOgTXcPW47U6bvGfrHAqL4l56WwSpiP8MLR9W5O4IV6BThlLLLSKKGp53
         EzXaGhUCbavN30rVB9nL/Ang0xtgXSJWu+PgSAnq5lw6JohjYedAHOYLgrZN8aHMIQNB
         8VgYjYEFT8mAw3xlccPPHUNDpR2PsRF6Xp4v4jLCMB5TuhUF4do93RDF0wvb46tcLN4F
         r5WJc6I1XztmcikJPXMQ7BwCDEVWBhtgW99ik3LR9W+ZI/+tBeeK0XLH38OY/bf0BvA7
         JVHrVyznqIxCb+yFjR6xkmYJg5d0PJhB15+U/NCPlyyGiUQYhDRZ5UrhRug6QhMhqa8D
         Zayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155467; x=1707760267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+3gsjZOPYy2xJyHlTt4CW96ozuzzW3lRR0ii8blzlI=;
        b=wjCTEwlswF5+yKASDlQocbOTEGKOxSsArV2wqoB9wVV0v+cNr93Duy2Wp3vaVRayZo
         K+/DbCp7NODUobgG+rYeafjNPdzjdV147Wan+4ReyWXp7l6d9HZsYcemz+fJaHG7u240
         ImbZqwVF34Kud9hNGOdWaOLqYGelj3DflnPTXIOIpVQiOwXSzEHijYpsrdo0MmG7Ha3A
         4SwQ9Hw7eBW2nBHVyuBei/kWoYU2tLljg3aJTK3j0dogE4j5zK7moMTbaIyGYc8Fv423
         u5TVaaus7hBYTrmuYs0pl2oPJTAta3uSS7PjlkJEv5x/DE17YAW67EJ74+G94a8Z+XiF
         dn4A==
X-Gm-Message-State: AOJu0YwoXJ+BkCamogsMmou+ZL5iXTu0vJdz1ylYrEwX59hFkFCuwE2P
	A0mRhMVLDzwgl4PsV+BPYRkvlyzOryqOedrvDCJX+TblngtYqnb4wpA1hYxYEbaB0StiYOuFhmz
	x9mvWBVUy0MdHM3/NvycjuMMNwjE=
X-Google-Smtp-Source: AGHT+IFfILhoGsG//DMhx2LZoqUyGKqUqKAwFwG4y7Df9lI/Qg5z1PyEx+BmdMjvW+AcTgVBtnlM3pdZupasLdpjrak=
X-Received: by 2002:a0d:d7c2:0:b0:604:3d4f:dbf with SMTP id
 z185-20020a0dd7c2000000b006043d4f0dbfmr439946ywd.14.1707155466748; Mon, 05
 Feb 2024 09:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-master-v1-0-6257d039a30a@gmail.com> <20240126-master-v1-2-6257d039a30a@gmail.com>
 <zeoywwedo4muolir5ietylb6xm2wu66wai77h6rvy2hkmu3u2f@f26b5cb3s6lf>
 <CACvgo51R=2WTcLma1wPSaDMu4QFtgezhGUKXf9k66Zg=6ZZ3=A@mail.gmail.com> <72ijqdtswcehmfjgodgg6chauou4vjkyh6ieup7osrcxbfwvua@arh6o2k2yddl>
In-Reply-To: <72ijqdtswcehmfjgodgg6chauou4vjkyh6ieup7osrcxbfwvua@arh6o2k2yddl>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Mon, 5 Feb 2024 17:50:54 +0000
Message-ID: <CACvgo50Y1=-+SxLMsHy-Nc66wt1=S7iwjthRU-UVeS_N7o-EGQ@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] make: install/uninstall tools symlinks to kmod
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-modules@vger.kernel.org, Emil Velikov <emil.velikov@collabora.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 14:30, Lucas De Marchi <lucas.demarchi@intel.com> wrote:

[snip]

> >I'm not a huge fan of using relative symlinks, especially if the tool> >is run as root. In my experience that makes things harder to audit and
> >prevent accidental breakages.
>
> I'm completely in the opposite camp. Relative symlinks actually make
> sure the thing you are running is what you are expecting. Nothing should
> really point outside of $prefix expecting that is mounted on /.
>

That is true and I fully agree. Yet the contents of DESTDIR are not
meant to be run as-is - it's used for "staging" [1].

[1] https://www.gnu.org/software/make/manual/html_node/DESTDIR.html

> Several years back there was also the issue with packaging, which would
> complain when symlinks pointed outside what was being packaged.  It is
> dangerous when using absolute symlinks because if the tool used to copy
> follows the symlinks, it ends up with the wrong binary, copying the host
> bin rather than what was just built.
>

That sounds like a horrible bug, which can easily break your system
regardless of the project.

Would you consider dropping the leading `./` aka can we use `$(LN_S)
kmod $(DESTDIR)$(bindir)/$$tool;`?
Seems to be prevailing on my system with over 90% instances.

Thanks,
Emil
