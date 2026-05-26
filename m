Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118133D332C
	for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 23:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779838844; cv=none; b=poTCa9KqNgKAC0yelKxSPD2NXN8fhhwhjECwywHsMOUCWYA+/G8y6Ig+afGP7l582kTrV0qfzHbfIEvoZUOffoMhtcuLueNENMpKZ8S9Vhrrg+htjO9rN095OWebl8dm1aMXIZJC03I7e05JFQDT+vN/J2fdaOjFcJnabRYRev4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779838844; c=relaxed/simple;
	bh=8ddzaQpPIU1lk7nO3NywObbzd/d9fgjAwKKOFsq7vE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nWU7Yssbyarwz9HleHL1T9l56okSefI7bCnJvd1yjx8lf/0pOHdAT+NmDqhGDPYIDDaN+wZLkfsxYOgGZaYeZ2beFDeev/Aqn6qH2emT9u1SOknzvXEBkxfQ8NDCkjNCCZHbyB5NQNrYDuI/6Sj5z88qNd1FzShowF1qLSF2fUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZ8Oc71G; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZ8Oc71G"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30457ff05b8so4051550eec.0
        for <linux-modules@vger.kernel.org>; Tue, 26 May 2026 16:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779838839; x=1780443639; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K1GQjZOhKRA0cpDt8l/K+2WDzgefBcTkUmqo1xyKi8I=;
        b=hZ8Oc71G7fU5tiMyiNFCQ95v17M1VdYcqfpGglul06uqFuVukWIpzgHm5zyEuVlTW4
         3BR89v8i9HlKSC3TawFi9WplT70trGBII3biy3LllXpD4WYHRxX3BS/Yd+GNOW451trj
         KKJYFn1czHWNK1RhCGNSGuPABhTPuz3o339LDG6huzknhOrDkDcvOtwqzRpAD+ygWKyE
         11KwzllGJ8XcKNXKTWLvEKYSrt+oTAFAsIid6zcN8M69sZ6PK7401tfmXIObuYcN5C7T
         va3NdCkvh7IQuNZrH9VjoWFbSXnYFZ/+ooWiyDlYrZ3eb22foYSvPK0bJ2ZbXas0BM2j
         tWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779838839; x=1780443639;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1GQjZOhKRA0cpDt8l/K+2WDzgefBcTkUmqo1xyKi8I=;
        b=pkBZ2GTH8enKASEThCwFubJ3H+8gcyPse1GFmID6omh3j8zPyizdjhSjoduN1JhJkg
         oi3IAwT7QiXu1Onxe4brCv8aBZmEUB4NxtY0MKO4RyuGxTfO/RZDzknmn10ue+3kn7o7
         nlDR7Z44vmymynIC3evjVuPB5SIx1MFcdpkRqenqax60ohTEuI2BxBOJZuI0w/XD/wGx
         40hS5eeVPLYzGspaDG+qHw2Sz1zt3ixF1/khjAVtSxwwc25xBLL1wCs2nfeRGcpegg2m
         onj7h6ncoSRyXpNSRyjrheVVUCL0Bofr9Awd+OA4BS3r2QxfMqzTpjAaWhq7RQ83Fg1I
         fS2Q==
X-Forwarded-Encrypted: i=1; AFNElJ+O983VtlOxxoLr2PlsuFAJCenMWQ7sPqhNori09Lnu1N9jb/nQYVLR8KEnXiOlMRYXv0ywTDNy0DSIcyc3@vger.kernel.org
X-Gm-Message-State: AOJu0YyjE/C6072Ul8YmR0vgAEhqy/Jq0jfhq8RYPVdDz/Ckaciuwi10
	nok1PrqUxrZvnJf50xtp9sOOO2noSOSDvXDef3spcPd0RkqGEqa0g4sEDgHlogIcqazzeQvbEti
	dxAShTf5GTlBdT0lF5Rx+2jyAZKybig==
X-Received: from dycrm18.prod.google.com ([2002:a05:693c:2a12:b0:2f9:af7:5053])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:a84:b0:303:f2fc:c483 with SMTP id 5a478bee46e88-30448f30872mr9330662eec.1.1779838838965;
 Tue, 26 May 2026 16:40:38 -0700 (PDT)
Date: Tue, 26 May 2026 23:40:38 +0000
In-Reply-To: <20260327080023.861105-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260327080023.861105-1-petr.pavlu@suse.com>
X-Mailer: b4 0.14.3
Message-ID: <177983883822.35274.16490796584446355825.b4-ty@google.com>
Subject: Re: [PATCH 0/4] module: force sh_addr=0 for arch-specific sections
From: Sami Tolvanen <samitolvanen@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Aaron Tomlin <atomlin@atomlin.com>, Joe Lawrence <joe.lawrence@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, 
	linux-riscv@lists.infradead.org, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 27 Mar 2026 08:58:59 +0100, Petr Pavlu wrote:
> When linking modules with 'ld.bfd -r', sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in the
> resulting .ko files. Relocatable objects are expected to have sh_addr=0 for
> all sections. Non-zero addresses are confusing in this context, typically
> worse compressible, and may cause tools to misbehave [1].
> 
> Joe Lawrence previously addressed the same issue in the main
> scripts/module.lds.S file [2] and we discussed that the same fix should be
> also applied to architecture-specific module sections. This series
> implements these changes.
> 
> [...]

Applied to modules-next, thanks!

[1/4] module, arm: force sh_addr=0 for arch-specific sections
      commit: ffe1545ce8a0a7bb698d5f68cbbdef8f93d1fce6
[2/4] module, arm64: force sh_addr=0 for arch-specific sections
      commit: c5553deb577fe433f770e270fd9582b8325f12d9
[3/4] module, m68k: force sh_addr=0 for arch-specific sections
      commit: 9cb4d4dc82272538de1b7edb6e8cf91597ed00b0
[4/4] module, riscv: force sh_addr=0 for arch-specific sections
      commit: 04e17ca3f77e1722a5db068fbcd7b93c51656013

Best regards,

	Sami


