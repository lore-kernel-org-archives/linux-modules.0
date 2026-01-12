Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BA429AAFA
	for <linux-modules@vger.kernel.org>; Mon, 12 Jan 2026 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240674; cv=none; b=cq0e6DLS4fF1BZGvXTpxtTVX5ALpIaL4WmD+PiNAx1CK4/sbSnBM/04+GccSukj/7EFeFvh846oMuqes4k0v1CnSUfaCdyL3GnPzII0OCYgydyRCh6zhUWJCPBdI8yXOuqU6vXlY6lV8105JmEHV5PhnkxXBri3wODAfQktfD3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240674; c=relaxed/simple;
	bh=u+7gmWfFywdR6yECG3YIIisIO7RBFjTTtNe3v5tUG8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jwoy3+XjPBOaFIn7uQQKRuX1XD5+kSC8hNyakiBNNri9l8v/sKwYv7MGHR+BQ0/q7+xaPeqYDcvaZ0M7UngUzWMQiojv84S7VKyNS8mMxVplDuo6IOAkGpieoF1HiwmMokWb8pGsPigSBSSztlO+6EhzBHiFddNuiIfrT1NhI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWnZq23X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWnZq23X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5462C16AAE
	for <linux-modules@vger.kernel.org>; Mon, 12 Jan 2026 17:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768240673;
	bh=u+7gmWfFywdR6yECG3YIIisIO7RBFjTTtNe3v5tUG8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KWnZq23Xv0HriTJ67U7QiT3/y2LKp9Isnj59gNN1JmR0G91jqOcManutbtFqYR+oB
	 W347OOpm6cY9xgETzOWxX3d4BoVU3fvaPznhgqVDhOF7TQiFWtlG8hTCX83uRstwGe
	 rKPNyDD7i/NPk+jugsEMk8igKgK480fPEiqHvyyUXfyB5et1Y5hp5kAajaL0S3w32K
	 59ixAlpWutalbksRj+7m5oOkqiOcEVywx4BumX9gZaY7yZCvChFC276AyZM3QmrFbS
	 6T64/egqFMiyrKvuUNBFEO+iHk3/WJrLXHQHYKBetKSd7Uap1Vp3SmBeQwkjdzmnw0
	 SepsqFn4MAzYQ==
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f1aecac2c9so69456851cf.1
        for <linux-modules@vger.kernel.org>; Mon, 12 Jan 2026 09:57:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXDmlXAr9tlkPIdzv3+/8xvkQAABjYTPKNBuCj4h2xtHseGE3K9NjsBfY4CqaS4QHUm9cO4NRm/2y8C6RjA@vger.kernel.org
X-Gm-Message-State: AOJu0YwWL78ybIOfgXIdoQ1iEcZ/+PDmXRhLkoVK6GOXS0CjG/zmTr20
	bf1os4bl4ATqvbvgWddJl9xWV4iRtwJOQZwEunISN0EZnOozw+273SjvE/xxdlRtDZNUxJ3yNgR
	j90q0LWFZ1qY/JQd8EADrcYyZBBxnoTM=
X-Received: by 2002:a05:622a:11cd:b0:4ff:a8a4:1071 with SMTP id
 d75a77b69052e-5013972f1e4mr3559731cf.1.1768240672945; Mon, 12 Jan 2026
 09:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107122329.1324707-1-petr.pavlu@suse.com>
In-Reply-To: <20260107122329.1324707-1-petr.pavlu@suse.com>
From: Song Liu <song@kernel.org>
Date: Mon, 12 Jan 2026 09:57:40 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6_P=nBDkAeab6Eu36hMwRPtT=GpB46fFRJ7MDq_kJ=Lg@mail.gmail.com>
X-Gm-Features: AZwV_QjPlmzz5z3pd8BuPOoboVkAPeJ6xjKTekdYZGcVUIaHsc7em4zeDoxgSA0
Message-ID: <CAPhsuW6_P=nBDkAeab6Eu36hMwRPtT=GpB46fFRJ7MDq_kJ=Lg@mail.gmail.com>
Subject: Re: [PATCH] module: Remove duplicate freeing of lockdep classes
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 4:24=E2=80=AFAM Petr Pavlu <petr.pavlu@suse.com> wro=
te:
>
> In the error path of load_module(), under the free_module label, the
> code calls lockdep_free_key_range() to release lock classes associated
> with the MOD_DATA, MOD_RODATA and MOD_RO_AFTER_INIT module regions, and
> subsequently invokes module_deallocate().
>
> Since commit ac3b43283923 ("module: replace module_layout with
> module_memory"), the module_deallocate() function calls free_mod_mem(),
> which releases the lock classes as well and considers all module
> regions.
>
> Attempting to free these classes twice is unnecessary. Remove the
> redundant code in load_module().
>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Acked-by: Song Liu <song@kernel.org>

Thanks for the fix!
