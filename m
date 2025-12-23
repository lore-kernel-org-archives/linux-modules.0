Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7312B334C2A
	for <linux-modules@vger.kernel.org>; Tue, 23 Dec 2025 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766500085; cv=none; b=sLM8GBN+EGBw5P7nFEsX+Dde3+ZaKd/m0zijHIvxJ923h4VgRsYPiH+mW36RnosFiDFFDjrkxf+iQKBoLEMofZP0Q4OGoF2qGzH2NQJA+QGsfB6U5eJiNeAPwHRIdpTE5w6Uh/8YaxMFxR3rEem2C/ldcXqZWJV06D+wJrwlseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766500085; c=relaxed/simple;
	bh=t1prazryJ5oAJ/r4ViTc4BXQHrdyplVUdlRTneZQA0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBvRymuc4KfpVf6aXJMGyfjSvLctSXMvxvOGFDHoRm4aAoovrrwpSxlpWAPSp2lQ8KDPunobEl0N5DMchOXz5HhZKR2f50jL8qtfDkr3sY2ezKlQrajBqikuDMsgISwUQrhJFW5LaBgUQAQyfH3SddjtcA1dQHI/29YXeyuhCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a+pPeUlt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a+pPeUlt"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37d056f5703so38473011fa.0
        for <linux-modules@vger.kernel.org>; Tue, 23 Dec 2025 06:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766500081; x=1767104881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3F5t+zdrNBSvkerR+/1xzzY60B8v/T75PNfOIeKAizU=;
        b=a+pPeUltOc3i2WlazzQRft/psc729uHsIueR4IMOJWCbXuTXxw3Ig4i6dl/9KuZ6bY
         HxGJi1CqKlqOc/j5447onysOkrXwudjtPrvIEf5NMTC87ndOEXkIZRqDr6CLlHBwlvld
         CJxbRyyO3xIQSVkTPUF+2Yy63FBVAGnZjdsdQNYH0VDNbVHt3/cOkWkexomN29VLz4vY
         2K+gCIsKydRt0h/3vPcbIqNUIS23yY1OdlnpJFvsu+iWBADkW7HVzMJKhAo/Ke1rjw8r
         CZv0i8Dn5s6GkNAqHmppWq6vq3IHmo/q7XEU/eatc+em5qahErqT50Bh0xDseGbIKUNc
         MyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766500081; x=1767104881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3F5t+zdrNBSvkerR+/1xzzY60B8v/T75PNfOIeKAizU=;
        b=Gv3oX0hxMiBPVtu5nHKAsdqGR9Ka1yBBIFJZ+UPJwwValEI0ou2Y0THRAxbOshhWUn
         TPZhzZPyIdM6PNuRNMxJzIfT30Y6xwrMtMOQjnuMq56QPqKMhmIwBDr3YR1Rs51N9SMz
         fxpl+q1wA952O/p+FuaxrKMam92iBSHZ1s5E39J2esKb3kiZxvZAPcKQPphzUuETsgn0
         fYGsXE8i6l5OwvJecxbsXB8/F5/aZpIFY87ifZkS6Y2Gh0b6QWb/E63QT17jVhJLJbRX
         WH4Rbfp8C2Wg0vz1lyp5DXUjFjPPvPUmwjSGVCw2lDMF7JHD1VhrtObqOWmwZgebu5Fc
         is4g==
X-Forwarded-Encrypted: i=1; AJvYcCUwuJ5OCu7VXYT63w70jW3km8V/VwSTZfRb0/Fg2YMRG+P/TNFcWYFds5Zh5JWXlaZlbcroDL2e8HVoeC5z@vger.kernel.org
X-Gm-Message-State: AOJu0YySrgMLv8ZyDVMdwzEwwCaJUx7C4LK2KvP8dTz6g2ylCVy7mmqP
	/vDetPQrR25Xt8rLHQgqcRcl7d/Ttcbnf/nsgDrujqYr21eSR49l2DdR5ta5vK9nf1b+BKWxNKf
	svWIAJibTruXkTeHBR9imr5KWWEoj+YZF1x9TgUC5pQ==
X-Gm-Gg: AY/fxX73ltUMXZDWCTNwJ5X/t2LihpNL/VKE8s/5TvngBQEJwvbwJe7KETPTK2++giR
	L45/vjujmlIIg8oOZ51FSn+2Q8EDvr+RYEVIuPPw8zjtVXvVqEr7xLiye7kcQ7M8wWuGuQoW6po
	icvzvt3JPl6CwLFAlMuQhwevIcQYaBA8E7f+LqnVf00gey5s+e/3ajSK1CvPQnU7zYN4Czr/Ild
	ywij929/0Wlvi3F55ahsialALndgxkuhq5OmUOw6/czJJZSyTo+lHYl5h46DOWIKAXj9/UxYQiW
	uyHewnrFeVU8p6WHZdjQTnfT4BrP
X-Google-Smtp-Source: AGHT+IHYnT2Yufb3BZpI8K4u/xXErZLZFZG3lC8QX03LwEswIUM6tnkajLqZcbykuzmFrKXijsya7QGKpKAlDkGnZOo=
X-Received: by 2002:a05:651c:1b96:b0:37b:90fb:9caf with SMTP id
 38308e7fff4ca-3812169eee6mr43279651fa.41.1766500081566; Tue, 23 Dec 2025
 06:28:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111095049.67658-1-marco.crivellari@suse.com> <176643400575.1902051.11698155532364546867.b4-ty@google.com>
In-Reply-To: <176643400575.1902051.11698155532364546867.b4-ty@google.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 23 Dec 2025 15:27:50 +0100
X-Gm-Features: AQt7F2qliNT-4nj7MW8pqGvhUQvuL5E4dHnTl8vUuxT_R-rN7CtCrV0SQbJKQGE
Message-ID: <CAAofZF7GdcquDXE5qWqf-dRnD6N=4Dy+AOFP=ErWrL_X=XpsLA@mail.gmail.com>
Subject: Re: [PATCH v3] module: replace use of system_wq with system_dfl_wq
To: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:24=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
> Applied to modules-next, thanks!
>
> [1/1] module: replace use of system_wq with system_dfl_wq
>       commit: 581ac2d4a58b81669cc6abf645a558bce5cf14ab
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer
