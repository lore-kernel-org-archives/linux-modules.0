Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F11F23E325
	for <linux-modules@vger.kernel.org>; Sun,  4 Oct 2026 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104435; cv=none; b=s/X26+FDp1RTp4nTEO93CjNLBQec12cwUYc+5YVREfaFZr3nU8tc6K1OwU2Cx79JED203c83ZSHoPTG1eMkh/IeDEI8mHSYZWi47ZM7/mE6L2HZhLXR7YdWEKA5m1s3/5DMUwLz36/o+Z0BL0ae73ktmFhLTByeljzyo8cPOu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104435; c=relaxed/simple;
	bh=wsOjbflYJOCzfPCrN9ZR4veXwOLBTjJtqAT5UNjjdUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bNZRpXQIgM4Iij0w1ez/iW2g2KZXH//vt+r4+5Yxc5h1AI3AOkALAYwMS8t2yWNnsqT5tocG+0uLcR028GphYoMJsWyJa4db5M+f4F9XZnivarz64kVzgfTmdR/HezouHl2ivKotxCgexrgfsIHB0DP8DaJuUAoQZrl0CATlB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhOgfSWn; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhOgfSWn"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f635552aso540824f8f.2
        for <linux-modules@vger.kernel.org>; Sun, 04 Oct 2026 02:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791104431; x=1791709231; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eeSFaU7bMGhPivfbbmE7Q112ihVvAY5ay3MYxKhL8T4=;
        b=VhOgfSWns1KfDlXXNWfvZRJrOuFHof1sO5kKSGGn6rFX9eszkQQPnO6DrlYYxhowYP
         2OpuJYaGiSvVQYSIGITD/T2N8f9rhJzF6MQJKpFHvYvbnFRfs0NSIB61Q/30Ndesb3Rz
         hmK2AYzSvuUznjXNaU/cxEzY2OmqyreJRxdtswmtolvLg97iE0itOtNd2jHKKdsHpl/t
         YbeicJ1IqOpJbcoxQpnF9f1gUsnpBhko4excPTgCVAux2ufy8RJ/lUk/7HyjjXS5Dejz
         K13ZDksgydMr/9wokk0GONvcdRDXllSDcIAX4tD5DCybLfZe4pthDATzz2vE0xrgQ1Yh
         gzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791104431; x=1791709231;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eeSFaU7bMGhPivfbbmE7Q112ihVvAY5ay3MYxKhL8T4=;
        b=pF9IaQaUYcyMJ/OkVsPjoL+SIMjOMMGfbbIM0ppMa3EzOAk7ErQiR08/vPgYBCMbXr
         BoxiX2Ao5HvcgVgzhoZJvaB5WJ5dScxl20yDn3nyl2xok7OSJpQGeiSgHy5DxQQhkldi
         w/FVqOgRP7gL0l8jqHTXoB0IxWbApXU87i7KEMxHXw0RSylyiXE5CezsVUDtPRx2XEoW
         SQ3MawhprigdG1PrqLQG6tsY6fqgmgmzjE+UAcHF42CgmbCw9Uw+180DbSEgZm+nfk5z
         nKrqwRG8DvloFJTlHDnHYVRAHCqkQ7UCLQLo1cnu+gT47beZzfFPSrTQEx49wDAznvGh
         tDjw==
X-Forwarded-Encrypted: i=1; AKwUvBxzvDpnZRvFormXPi5jJo+PtJY0ZRVIZ39eaD3mIHGyP+xpH57Iy/t76Jy0CRKW2BXxalXW3L+xDxat9/jf@vger.kernel.org
X-Gm-Message-State: AFq9FYKlo0CU7PCvHNksfbI0ZzyrD3wnKq0vAq9ftqV8NLNVfzQZIggg
	rvmjlnPzNYubLrdJo+TPEZuFxJSA72DA2pjFQTEP7UGV7vrxIBXI4QySJyfF/rn9
X-Gm-Gg: AYBFou39mOoKnFiQjnVGs2orF0ljLtT/+iJOWjTcUY1+cQd+KtBBA8pg0stqoILzzwk
	8i2H170H/zJ0c3qAkK0VVcJd9UDxA44cfm7UHWTc7yF8Jz/Ggp9RcyBnD55hnKEs/5fQWe5H1rt
	nHYsnnYcC0gfJ+o9VmODhbJlKGolw2yBwhsOzJFO4hPhMbmjAe6mZVuF+bhJ/shXhAvpXYdC81t
	fPJbtsDsndN9eynhEkuUsEpH8WD5xQqF+JHmnPqjQJDP/bEsRXSufiIEnkYalRKtUN678i6JuIJ
	3tviyLzOSIZ8nYmlAzjO4Csee7L0n/KbPWz5yuu1/twr//byuoWDtVOh9pcldSbj7xFEX9TFbbH
	aDFC5J1zrhQR83dI9ik48WEtlQJ56uF+L+o5f5l5ACNoOF59I4o6Br2BeLc9LD/R3PE789J/Zh4
	xEyoKuAVf7yW4N+9Agg0pGeigxWqPFch/M0lz7iwsUCX5nzyKfu+hb+A4LsJ3exI9djxIaqqoPh
	6xAb0W6x9DLjshFnCPaJAyWVl9a6Sh+7oo2
X-Received: by 2002:a05:6000:4717:b0:487:7fd:730 with SMTP id ffacd0b85a97d-48b1271cda5mr13569157f8f.13.1791104431541;
        Sun, 04 Oct 2026 02:00:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380f0613sm19370590f8f.13.2026.10.04.02.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 02:00:31 -0700 (PDT)
Date: Sun, 4 Oct 2026 10:00:30 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org>
Cc: deduce@gmail.com, Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Petr Pavlu
 <petr.pavlu@suse.com>, linux-modules@vger.kernel.org, Stanislaw Gruszka
 <stf_xl@wp.pl>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Avoid quadratic symbol lookups in
 ftrace_module_enable()
Message-ID: <20261004100030.189b1c3d@pumpkin>
In-Reply-To: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
References: <20261003-ftrace-mod-bsearch-v1-1-92e2fd2d80ff@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 03 Oct 2026 11:27:10 -0500
Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org> wrote:

> From: Lawrence Lin via B4 Relay <devnull+deduce.gmail.com@kernel.org>
> To: Steven Rostedt <rostedt@goodmis.org>,   Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org,   Stanislaw Gruszka <stf_xl@wp.pl>, linux-kernel@vger.kernel.org,   linux-trace-kernel@vger.kernel.org, Lawrence Lin <deduce@gmail.com>
> Subject: [PATCH] ftrace: Avoid quadratic symbol lookups in  ftrace_module_enable()
> Date: Sat, 03 Oct 2026 11:27:10 -0500
> Reply-To: deduce@gmail.com
> 
> From: Lawrence Lin <deduce@gmail.com>
> 
> Since commit b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid
> adding weak function"), ftrace_module_enable() calls test_for_valid_rec()
> for every ftrace record of a module being loaded. test_for_valid_rec()
> resolves the record address with kallsyms_lookup(), and for a module
> address find_kallsyms_symbol() scans the whole symbol table of the module.
> Loading a module therefore costs O(records * symbols), all of it under
> ftrace_lock.
> 
> For large drivers this dominates module load time. amdgpu.ko has 16821
> ftrace records and about 67000 defined symbols. On a Ryzen 3 3200U
> (x86_64, v7.2.5, amdgpu loaded from the initramfs), amdgpu finishes
> initializing 6.2 s into boot without this patch and 1.8 s with it, and
> the kernel part of boot reported by systemd-analyze drops from 6.87 s to
> 2.47 s (four boots each). Loading radeon and nouveau, which have no
> hardware on that machine, goes from 170 ms to 87 ms and from 520 ms to
> 145 ms. Commit 4099b98203d6 ("ftrace: Fix softlockup in
> ftrace_module_enable") already had to add a cond_resched() to this loop
> because of amdgpu.
> 
> Instead of one lookup per record, collect the addresses of the module's
> symbols once, using the same filters as find_kallsyms_symbol(), sort them
> into a temporary array, and binary search it for each record. A record is
> valid when the closest symbol at or below its address lies in the same
> module memory region and no more than FTRACE_MCOUNT_MAX_OFFSET below it,
> which is exactly what test_for_valid_rec() checks. If the array cannot be
> allocated, the per-record lookup is used as before.
> 
> An earlier attempt [1] sorted the module symbol table itself to speed up
> every lookup. Its review pointed out that livepatch relocations index into
> that table, that the sort is not stable for aliases, and that data
> symbols and weak functions need care. This change leaves the symbol table
> untouched and only compares addresses, applying the same filters as
> find_kallsyms_symbol(), so none of these apply.

Surely it would be better to add the sorted index as part of module load
so that all symbol lookups could make use of it?

I think the existing symbols are in an array, so you can reduce the data
size significantly by saving an index rather than a pointer.
With enough __packed you can use an array of 'unsigned int idx:24' so that
each index is only three bytes (rather than 8 for a pointer).

There are also places where the symbols are looked up by name.
That needs a second sorted index table.
Although alphabetically sorting the names during build might be possible
and doesn't have the same problems as sorting by value.

David

> 
> [1] https://lore.kernel.org/all/20260327110005.16499-2-stf_xl@wp.pl/
> 
> Fixes: b39181f7c690 ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Lawrence Lin <deduce@gmail.com>
> ---
