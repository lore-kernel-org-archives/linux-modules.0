Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731F44CF59
	for <linux-modules@vger.kernel.org>; Thu,  6 Aug 2026 11:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015186; cv=none; b=cPP2bi7aIuUvLoZlZY5QkolVKVotq/47SpP75eWHEbBx02ueJCOs970sgpP3BnKyPok84/HlqjkbjUsvmtRrugdvFKLzGtMDtQT9t+3DAWrz/gWcSOUah3NAtCHpbm3ylENj4AoHOTnH0LqLCDhjzaer4iVxnueHypZItInhzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015186; c=relaxed/simple;
	bh=CnHpUUI7pdIhBuSRzNEeZEWMMDj4WVealHeIlZkbQAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FoSsvSEBejkp29m52sIlzR5iLvBti1687UweUdSK3mh6ROvIuu94S4bDO9EBeSNAhYsVJQibkXBQXnDyZTfovnLkYhS4ez88IOc8oOfoYRTSEfHfF7LrzS07cKc5H/e7z9aj+zNlLwJO1QFEDXKF5Ua62lKNmHRcju9fVsmtR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PodvnevY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PodvnevY"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47fde295992so703030f8f.0
        for <linux-modules@vger.kernel.org>; Thu, 06 Aug 2026 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1786015179; x=1786619979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=akASYRjtF6BO4x5KD3iTDLHDlzLsjhfQ3KKqFIPbzo4=;
        b=PodvnevYX+E/rWvT399q7mD0i4Px4AxbwYDYg2goNp8E5xaR9qCc9rr2oZtBNYg/kz
         lfTqFWUzEa+66LKN2uHTUxi1Fxbg4o6vL06Uo7R20QToCtW6PL7uapbr41osiKNFUTQ/
         bk/4H8ZdbbqHdSOwMCMYdEvWRGlO2speCLZGJvNgYkSN/i1FmZWxBFCPJEEedv+zXe0g
         1HM+BKFC+KCGcKkHMo93F579CORzCDP+Og9LyfdNbwl4YQU7zFY+UMGQ0wqB2uI26IIk
         OWo2nhhsQgc8OPWUxNyep4k3r07PPDccC6gMON8DqVWpGi1kPLmGMswD3NIG1jMZfLts
         5TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015179; x=1786619979;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=akASYRjtF6BO4x5KD3iTDLHDlzLsjhfQ3KKqFIPbzo4=;
        b=Ywo/EV7Rq634vlVK65qcuvHGrDCxIUT385pywoOO3sH0aUhB2pqa+kKqkB3CQJrWX8
         BgI59Y/0t3y1s9Jsa7StEj9V9ea8ilfItZ4cwI1H0q03rAOZJLlHTOpn4csZg0UvYwZM
         KS9htMA0NTgTTVFKRl+Nif+bL1iQuS1dQ2yGC+g9sXeTbnMNhlsuqU8vSeyAN9cwrljX
         mdY/xEEO2iuB6+FEyTGxFIZEYKH2SXU1kf45cQ2K/Qju9KXtMdLe7SCfQ4dRFu+N2nFg
         bFeWhTHH6hEvz7DSlCYf5O9yhbFo1HqGKr+v5A/OKfRIWi90dc9d8AumlDALeU6a1c63
         6kFw==
X-Gm-Message-State: AOJu0Yxz8yzNT82tQM5Sq8JSdAqWCwaLhLguX6DZt5LyHrit5Su9Kd0n
	JT6wsZVyXWr5Zf6QPQCFSxyeUzy/JAV0gR6hKtqkUFNrvJerCM8urlO99aQTpIn9/fzTMRvtSjp
	/FNr6h/c=
X-Gm-Gg: AR+sD12eC3Qlp7pWn3cXfeomw82jNQObARDD6lrtO2F+j+ZN7y2Ws3IiE0w0HVH/AhN
	IrfzDuzoH5zXbjhmOeDK48nEWo3xioR+36WENvTfDo8alup4pCiGQAOPBP5+pNllFWpa+iu6ZYx
	HPTyieYl7mrLjHKTVSAUXWZ7iCXOfNlr5nkHS/5kE9wk7hQT48c0OwHMhFDFOU2J7JoeWz44Owg
	xKY0+slpl38qjrwWdhSuhMSMU7gCBaRN/YJfzdnBsWulpxvd2DN8KZdFNNhI8d3+HVlz/GKRbY4
	Fud1hwNOfCymTpNmK/j7K0WF9PC/vMZaTk0/R3vI2QZ0nEdiLfdBwoBw9FCQhSPMcbHO+v7l6Uj
	d+1prs5qc+OVB6u5YQk+gZZl2NzoGY6fNb843bD1S2U7Vr39M835lcAmW4y5hES8dTNATxdPWKc
	3T79Mo6uqjJlJnvSMMiqbiWDB1KKWF5uEYLs6jXNA0oOojlX6FmT+PmTYGPAeE+95kQ5UlbEqRH
	LkFZbQFt9RWNEmJEAWk/tf0FA==
X-Received: by 2002:a05:6000:4007:b0:47f:ec53:1d2d with SMTP id ffacd0b85a97d-47ff4cc3307mr8830084f8f.7.1786015179457;
        Thu, 06 Aug 2026 04:19:39 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:fc6c:f9a2:4a0a:6354? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b3279dsm4987381f8f.36.2026.08.06.04.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 04:19:39 -0700 (PDT)
Message-ID: <b8371d0a-b5f5-4091-8bcc-c6d337452f5c@suse.com>
Date: Thu, 6 Aug 2026 13:19:38 +0200
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] module/dups: Inform duplicate requests about the
 result directly
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org
References: <20260806-module-stats-rcu-v3-0-2b0331106f00@suse.com>
 <20260806-module-stats-rcu-v3-1-2b0331106f00@suse.com>
 <20260806092534.4B8E41F000E9@smtp.kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260806092534.4B8E41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 11:25 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Re-arming `delete_work` while it is currently executing leads to a Use-After-Free and timer corruption.
> - [High] Waiters sleep in `wait_for_completion_state()` without holding a reference to `kmod_req`, allowing `delete_work` to free the structure out from under them.

The series fixes these use-after-free problems in patch 2.
