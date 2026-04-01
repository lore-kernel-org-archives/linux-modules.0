Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BACB2D0606
	for <linux-modules@vger.kernel.org>; Wed,  1 Apr 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007023; cv=none; b=kItKOWBPQfJ1nIi9p/pvSFBB+YzRC5VS/hchqeOW16ggFMOVXoVk1oH+9XAFYYhzF3cMaygTHt6bREz4yqp4IZ9FO1QbhNbhAB5aYM7DDOatLWYxuumU0+7Pf+G9NXtMrtuZ/2hnhkUgDbUkcDqep6sDiqfn+MCxn24m2uUI4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007023; c=relaxed/simple;
	bh=31TfvCLwbknK8QU0XVOHI6FK0vdxmYqr/snmIVckegg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=suNWaRIBqJxo9hFpjTTekJBkce0hv/uWY6wN6+attLXZ1TnPqBKLT+vyvZeylSf+HmNfNoF1+z/6MLHvNre4kO6h3tsCfj1GN1ZFrJPMvQLGVX49+FKmbzhZbmkEfH7Uv869xyrP+fnQGSG3b0QWmReDRwZWqzjca67bjHLHtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKEW9F1G; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKEW9F1G"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bdf75bc88fso5470654eec.0
        for <linux-modules@vger.kernel.org>; Tue, 31 Mar 2026 18:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775007022; x=1775611822; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k1/BQLq9I+ernXavRvxZYNZROQSXYmepGs6Tk+w+QVg=;
        b=jKEW9F1GtFDJu1oSrVQ4fBmh51vm0ej6HPOhm4jQHGM0AICgFsvYpC5w8JyATLvuKt
         qgGnGu59RpjSsyH4RR9wt3fFvKp7V+i9dI8RJ6ckYyfCYtrJ/zDydvrhc8O/3kJ/jjSN
         q0sJ3cCNpafYYrlmhGucxhDyn4CDKIgirsGlyfDsCHT6Rfdom+k/cHN3svkXwjCPfYXj
         94HrWnd5CHpLT88AGgNxxb0ObQ7k533Y02V3hf/sPB/E8+zey7klT4NJVuva4Pkeqakc
         cIudRDdfke5m7rVJDhxNjUxZngRaGbjfmYz1S1gdiRdk+uKztHrqcWONAKbMzGO8ZdJx
         Sjzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775007022; x=1775611822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k1/BQLq9I+ernXavRvxZYNZROQSXYmepGs6Tk+w+QVg=;
        b=IV8JYoufJKmzi/y4qnzXkMzFvrUTioVBTHf8htkbTFjthHdZm645lggX7D5htHB2R9
         WC5/T57vSwAGWJ6NGR4j+ddi82vgXwjBzSVI+P0lDTXE1oT57K95OYmXqbqUWDdgi5Dj
         LwewYDg9eqEifgD1IVj1u6ToWjxkJw2tNqx9coLyJOGyU76oZ0klDXjwyOqoERSg+ebG
         rlNTGFX8EuwKLzulBBdg9X/9rlyqC1IqOKwQ5OFrahgJAVVJZT81pVET7dd4oufBKE6A
         kU/X7hPl22dRTQEwcVOZ+h7rCWUt8zH5wZax2sZAP24jr+cCQCbFNzBWXn9MZnfi86Sk
         ZVoA==
X-Gm-Message-State: AOJu0YzfKTGS8vVH0z5g98F+ac/jGA4I9MPMLGTIG/DNSSxoJNbAB7zr
	SSYKsYDJaUZWbZmxVMBrmfaZeSmfEdY+s3sYJbYj68uUNtVoWBMviJO66+ei3BSwNXYhdCLxg2Y
	2wzt0LDokjbeoA7KUe/dslDhaSWo7Aw==
X-Received: from dybmh41.prod.google.com ([2002:a05:7301:f29:b0:2c3:dfe3:6dbb])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:693c:2c8c:b0:2c6:2bac:8a8 with SMTP id 5a478bee46e88-2c9333b8061mr822830eec.30.1775007021499;
 Tue, 31 Mar 2026 18:30:21 -0700 (PDT)
Date: Wed, 01 Apr 2026 01:30:19 +0000
In-Reply-To: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-kflagstab-v5-0-fa0796fe88d9@google.com>
X-Mailer: b4 0.14.3
Message-ID: <177500701994.1603852.8130352881871388132.b4-ty@google.com>
Subject: Re: [PATCH v5 0/7] scalable symbol flags with __kflagstab
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Siddharth Nayyar <sidnayyar@google.com>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-doc@vger.kernel.org, maennich@google.com, gprocida@google.com
Content-Type: text/plain; charset="utf-8"

On Thu, 26 Mar 2026 21:25:01 +0000, Siddharth Nayyar wrote:
> This patch series implements a mechanism for scalable exported symbol
> flags using a separate section called __kflagstab. The series introduces
> __kflagstab support, removes *_gpl sections in favor of a GPL flag,
> simplifies symbol resolution during module loading.
> 
> The __kflagstab contains an 8-bit bitset which can represent up to 8
> boolean flags per symbol exported in the __ksymtab. The patch series
> also uses this bitset to store GPL-only flag values for kernel symbols,
> thereby eliminating the need for *_gpl sections for representing GPL
> only symbols.
> 
> [...]

Applied to modules-next, thanks!

[1/7] module: define ksym_flags enumeration to represent kernel symbol flags
      commit: 10a4eb5882ba16164ece86d99486084f02f148bb
[2/7] module: add kflagstab section to vmlinux and modules
      commit: 9743311b4535dc76ce81f46303da0f69bfaa5fd6
[3/7] module: populate kflagstab in modpost
      commit: 16d0e04f546ffba78c74bbfeb57d93147bcaf2c5
[4/7] module: use kflagstab instead of *_gpl sections
      commit: 55fcb926b6d8b5cfb40873e4840a69961db1bb69
[5/7] module: deprecate usage of *_gpl sections in module loader
      commit: b4760ff2a5e4351c59d185967735f59c0b0bd7f6
[6/7] module: remove *_gpl sections from vmlinux and modules
      commit: f18540256b70c9e1f0e26e2c38f3d43a131926d9
[7/7] documentation: remove references to *_gpl sections
      commit: 3b1299f25b07ef83e020d049dfc62ced9c09450d

Best regards,

	Sami


