Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8DE149C4A
	for <linux-modules@vger.kernel.org>; Tue,  1 Jul 2025 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377211; cv=none; b=GIB6APO4a/4JBN//HcL5rwHoyWYEBctKHXNLM+RtrMr7tSiFu/k68nsJzso/yTxjbAMWvyvx6IUS5/NZihWWGSjL8izD9KXiMN6J5g4UiS8o74iGfkvGGX99piwySlVJVVwRkQ0n1C0tOE4esPHRx5mBX9ejo+GM/SzDON42YB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377211; c=relaxed/simple;
	bh=0hRoV3e8RVWSoUR9QgHOtPTpPI6An/gOiQwUACBrsCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tjNTRwvKkS1OnPjI8Rc28mg082z+lzhWcnH7XMII1UiEHlPFZwTHcRiio8NnxH99529UI1MqRs3JRV+ONjEXiw/0CptqNQORUyGHxk1E4Uq6FwC2dGMhtK+4Fabla9a/HM4iqi9uB9B7UBZSO1zemh/GKyt4veXB5urtwQCmI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20497C4CEEB;
	Tue,  1 Jul 2025 13:40:09 +0000 (UTC)
From: Daniel Gomez <da.gomez@samsung.com>
To: linux-modules@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20250610163328.URcsSUC1@linutronix.de>
References: <20250610163328.URcsSUC1@linutronix.de>
Subject: Re: [PATCH v3] module: Make sure relocations are applied to the
 per-CPU section
Message-Id: <175137720983.26562.11867341838662890218.b4-ty@samsung.com>
Date: Tue, 01 Jul 2025 15:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 10 Jun 2025 18:33:28 +0200, Sebastian Andrzej Siewior wrote:
> The per-CPU data section is handled differently than the other sections.
> The memory allocations requires a special __percpu pointer and then the
> section is copied into the view of each CPU. Therefore the SHF_ALLOC
> flag is removed to ensure move_module() skips it.
> 
> Later, relocations are applied and apply_relocations() skips sections
> without SHF_ALLOC because they have not been copied. This also skips the
> per-CPU data section.
> The missing relocations result in a NULL pointer on x86-64 and very
> small values on x86-32. This results in a crash because it is not
> skipped like NULL pointer would and can't be dereferenced.
> 
> [...]

Applied, thanks!

[1/1] module: Make sure relocations are applied to the per-CPU section
      commit: 6c7ceed3f375bf9e2b093623af76df3094c88871

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>

