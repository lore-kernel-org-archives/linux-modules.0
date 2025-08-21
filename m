Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEA526F476
	for <linux-modules@vger.kernel.org>; Thu, 21 Aug 2025 23:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817932; cv=none; b=f4HiE8NN+fvGFIdvGmwda8q6l+3pK1AhopCZR6MSAdxA/aQMbYAFVnOxmz8/aBZzYMWd6X+gKIg1hRgQYjZAP9HLPM7XSSuwwZ//spjmBufiYsNrO80tuC44MRYLdA4dnuBkBvGR7I43/QF9lnKeOPcMgH5SZpAWcyZcxb2llNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817932; c=relaxed/simple;
	bh=JIel/FR57SwJcaLONH4epvfKs5IZENednDBecALaL5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N8ORNKXHKMScrwrUGkyIvkoshwNgBur5QUanPjqC6VqQ9+wYGXnmjLpjlOIBrtOj6wkETP5C5I1bV6PB/4m39R85x5pqMj5yM9A6x9UW9Z6/ILhBvgP6JRSxy3RL3CxCdyvPdD8P6KuHpWJQyPATWS8DhomY+Q9yi1s2dDw6lyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vqYXcXHp; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vqYXcXHp"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-246257e49c8so83255ad.0
        for <linux-modules@vger.kernel.org>; Thu, 21 Aug 2025 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755817930; x=1756422730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIel/FR57SwJcaLONH4epvfKs5IZENednDBecALaL5o=;
        b=vqYXcXHp5JhOaiVUadP5NSpBdFBBB5wBmhejZKZqrHVeZ04B1HOlNYGrrnnM63shg6
         zRhNPcYpU14pHCrkb6r3KX1C0IqDrhv1k/h3lZ+nlvgqxS9kiMDkK9RASTPC2r32p4+f
         KBb0mdbNiTOhmfCxnWL6UmBZafrT3IAUx9A06p7JrpcEozj+nHwA4L4ZcgHCgm+jxRd3
         NfwaT98HGycA0yOA+5POUKdrfinWfZUb+p6L5VN1qNOh1SbjN5v8f63R161FAJS9Q2st
         gLbqvlMdsFnkqqkKZTRCuMP79Jz+N5xLgfYVXpwVUIfHgTpQBEYTGr6t2wZXi2nAcu/z
         SmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755817930; x=1756422730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIel/FR57SwJcaLONH4epvfKs5IZENednDBecALaL5o=;
        b=RqL9PPM8SnFKUXQsWe+Gu63ONTQLjiCGG9+0CtsQwfRHqCjjLTf5/jPIcz6yFcj6d6
         c71qqxZuZ7F+VidmNzoVHMSpLe2Z4fprcXZKMGLTYleW7RsMXY9Num77wlW4ZFnZJtWM
         2M4l4jdX2sVqUn0CkUYH/u06i67TOl4B7wwATZZ1ApO1uFoYOafFWa2vfeP4lPl3cx5l
         746Tig7wWi92FGe/Lr4MT3lOZaYeCnbrgas+O07SE0iMnVHwMAgNNf3SvTP0OScOKnmZ
         NL9Bvx6BEQjAv+YnNGSjgh6LJpwWdVx7SUg5JPfOUtdfH+HEgsjriba6+VqmPQCAlJp9
         WtmA==
X-Forwarded-Encrypted: i=1; AJvYcCWVVBPdc0CZMPO28IDKdTPIxFLOJov3J/SmmcGrv5tLvn4rUeXAqyBc0pbH38nvLXTXl+kXmlVivLZ9sES7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qeXeEz236/SAHG40hdlEGn9TcWJHsAPS899QU1QVttGvin3T
	RyZopdtdRQer4ostlEdA+p153kUyEWvsAPo93lekop2bkib+NJCb8sJv77GJKINi2iaOnO1BFLf
	vCoX2sZeSPX7kPJr8TKeW2lDiLlueFhfA98EtjyHE
X-Gm-Gg: ASbGncv04IYcBG6TnNuSkd2CYACSUqGZSeqFZWwWHqPiINZEYRWIzdBVrQikIcrwsin
	lmwq0yVxHLgElPLge9j2FHH27j4riU1fK81PZuMX9YPoLSmYhQl9pCZs72zV2VcJuLLU/bHEFYy
	C/TpXauG1AmR+yDv6TIccTeriyxHribHt+N+gWk3uMzrdwPRQ2mXnzctunwcMHVDlO0nZX/H2D6
	GdrWEmxqp7w8XeFvzSa+w==
X-Google-Smtp-Source: AGHT+IF8QmYd0K/VI5mJAgjeH3O4OfadWqimUtglUq+qrkzfyXjMxzaiIIau5t02eTFPYvM/Nzmw/35u9YfJlun7tWM=
X-Received: by 2002:a17:903:32c3:b0:240:640a:c564 with SMTP id
 d9443c01a7336-24639f23c10mr767135ad.3.1755817929833; Thu, 21 Aug 2025
 16:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819121423.460156-1-petr.pavlu@suse.com>
In-Reply-To: <20250819121423.460156-1-petr.pavlu@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 21 Aug 2025 16:11:33 -0700
X-Gm-Features: Ac12FXzZLbDJuAQzCBqrbxADBxinz6u05a7iaZuaDPd8ioxW8irI--KZO5WfYzg
Message-ID: <CABCJKufX=ayzyb-0pGpLvT5ULdQcp6BeM06AVfLdEEN5-r4-tw@mail.gmail.com>
Subject: Re: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 5:14=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
> __INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6f=
d0
> ("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE wa=
s
> ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
> ("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
> this usage.
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>

Sami
