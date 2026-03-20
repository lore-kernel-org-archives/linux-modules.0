Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82762E54A2
	for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2026 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028757; cv=none; b=trwbSmgvYyLXc+sZpXXzn5it6EJWr5wT4fN+vYf8/K4vJYTay8m/asG9meDtjZa9Mth0UitwnARs+SXk+sE/9nQjkP173geP9uQ7pYUShDG/KAdX2V42iu+gp9S89JtOdJlaOiPu8PLzzuIkLmSZkrbZsdeWDfNoPNAYM+5DMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028757; c=relaxed/simple;
	bh=pxxvNmnYWrrC7lSMceFSjwC9c2YknhqgthmBTOcaYj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SDD0mPGY/QlH6QH7Mq7d4G4Xp7iQixhW5RuRCgiCuQOFOMWGyZNQfVE87E/YVXYHCDglYyo7FwuspbUKTaJ+giaqKuXOl6uRJc5dFu7qqQD6bMeaeyxpSX4bIa6L6KbyroKHFKDWFGQY2fFoOECNiwT6QaottweQwjCXjRqPY5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lA7ildpP; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lA7ildpP"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso1830069eec.0
        for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2026 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774028755; x=1774633555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HSTckojUIMWUPsHGCLzNd6Rpx/5NKHFio6PcCySPewo=;
        b=lA7ildpPKHSCgpKeRnb9Gw9F8Pr315r8AbHEDnN/GYKbf7xzU4DExUzl3kZ7ci33Aj
         kUG3P45LKxbwMpLkvru3IStg43GNfmapku9UD3AFJD25NSQyYZ3E0horhBx4Cr9rfs8h
         e/wml9dp7al3P/D/ITt2fsy5UmVMJ6/wT0i+zEsmMDmGqQL4luZBuifkdWcidDZTKbgK
         yPFLaFDpX6g0YkZ82vMVb4fXUp2QJp8JKj+DXbDUDj3uW+6tFoUgACPYZULBo/8lcvhF
         OIyh1wS2uRCoaB+92L8uJ6BM+DXEEwa+duj5hXfYbOXfKL0aO4Yi8vyRs3KWalIH/vxG
         VjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028755; x=1774633555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSTckojUIMWUPsHGCLzNd6Rpx/5NKHFio6PcCySPewo=;
        b=eIINWiLuoFkynMPGstZFCe8V2KeQKbT9+2qGtgSHKsIOuoQXyOMBCUmzqeeAhHY4Ou
         eQy3bYlCojRhB5tlXqeV2fzxN2SpxbmD9g48Ks8WoqXKSjvDiH9X5MKz9umTF6ouKOK2
         teLyPNQ3FlD0TeD6VdaUt2QBN00tiglcBxyglOX+TThwmoUFGcFwde4O19VleL5HdMEC
         m0j0SuJ5I1uCyfk3ubp+zFY7xVbyg3BLodrAyUtHA2rXpeLWmsU4Sj5NFPmuiqAmlvuu
         ZfOKOpfE53cuu8a90g29nu/MRPTrIT0TNyolOjnnRlni7bB6AnhVO7xGWl2JlkH4mU+x
         kF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbpCM1iqWxfii8WgPbaXAZhFNwSUSApK2lfeu34Ds0lLxtRBH9qM8ZLOyupkQm+PGhoaVM0v8YY5f2Qzq6@vger.kernel.org
X-Gm-Message-State: AOJu0Yze8mHmVl6MUS5foI6CgUVWC9ntTn576CgL4mzCEnt3a/sAL/5E
	714UFqKLUf0zH7sS4UbFedU7OleZTG8Z+PokjOZ/gqsOtfCtP7JvtA7kAr51krXeNDBmRjxT06m
	AO2sO6+smC/y3smFcu7lGXDBVJChteA==
X-Received: from dybgi3.prod.google.com ([2002:a05:7301:83:b0:2c0:fbcb:769c])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:300b:b0:2ba:85d6:e777 with SMTP id 5a478bee46e88-2c109567b30mr1586129eec.2.1774028754862;
 Fri, 20 Mar 2026 10:45:54 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:45:53 +0000
In-Reply-To: <20260313134932.335275-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260313134932.335275-1-petr.pavlu@suse.com>
X-Mailer: b4 0.14.3
Message-ID: <177402875381.3545153.14837068718372243586.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] module: Fix freeing of charp module parameters
 when CONFIG_SYSFS=n
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Christophe Leroy <chleroy@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, 13 Mar 2026 14:48:01 +0100, Petr Pavlu wrote:
> Fix freeing of charp module parameters when CONFIG_SYSFS=n and, related to
> this, update moduleparam.h to keep its coding style consistent.
> 
> Changes since v1 [1]:
> * Remove the extern keyword from the declaration of module_destroy_params()
>   and update the type of its num parameter from `unsigned` to
>   `unsigned int`.
> * Add a cleanup patch for parse_args() to similarly update its num
>   parameter to `unsigned int` and to synchronize the parameter names
>   between its prototype and definition.
> * Add a cleanup patch to drop the unnecessary extern keyword for all
>   function declarations in moduleparam.h.
> 
> [...]

Applied to modules-next, thanks!

[1/3] module: Fix freeing of charp module parameters when CONFIG_SYSFS=n
      commit: deffe1edba626d474fef38007c03646ca5876a0e
[2/3] module: Clean up parse_args() arguments
      commit: 65f535501e2a3378629b8650eca553920de5e5a2
[3/3] module: Remove extern keyword from param prototypes
      commit: 44a063c00fb13cf1f2e8a53a2ab10b232a44954b

Best regards,

	Sami


