Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDB1C860B
	for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2026 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028754; cv=none; b=C5Y6RcFnqFSA/LV2hNr3jgic8FEucO0H8MsBkE3peCfGzctaqvZxvtNNp+0wJwW/W0Y+204Obw1UX7LZutj0Q2glfXCkvW27QMMZCrVWTM1Y00ep+4QFuoCgBLj5c/D1AyVwkJktNlkO55wjyiKNmmtPOr7Oj96m+Z50BOPqRnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028754; c=relaxed/simple;
	bh=M1TnJyGoxk18zfJ7+bdEQa3L4gCGNW5McQWG99EOUYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tcpNuxZvGVawpwtJ/Rv3aevZYyW42GMli9MNl6dGMxoGJMBwoWrNKtfT6Wvkt12kJP1IeJOYczS/B/9wd75fy6WtBryveB4DWvfGfxFE2dDhhnSFYfkkxHrBHmqEzofn2tIz/gHF/SuT8mg0X3Itn41xTZHJIUTZQCq4mLdzi6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XjK/OrWs; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XjK/OrWs"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1273dfdaf5dso1333954c88.0
        for <linux-modules@vger.kernel.org>; Fri, 20 Mar 2026 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774028752; x=1774633552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0++HSGeF8vukyIF9xdQ3UG+tReehtKpPJp6a6k4VKZ8=;
        b=XjK/OrWs7mBqKvn+DKRupbVFDE2TCqXtSdY81BuIX6bgRkLs8pxoHlfZfqCXEAY58a
         JsK3UQlCpzbUIOM29gP2J9h7c/FOl2ssRDlJnHNFawSENgCQSiyR7BrGkb0ws5no84Ji
         qrC0aVnjcWNAxik3yhrCLv4XYtIINKJ09FAHfaZ4VmavN22pCQHQjKviOETL1xLUH1Hg
         G6mAktAAvKewKkHrgkNU1sCePcMUPLGkzviVHDRguCsnbb1J+vffJJHDGU/SwN80c5l1
         04loYF4qt+Qfoq5k26z68w8FK21xfB2mg1CPZx7ohJzeMdexMRVPrsyzOUY9YpVKVuGG
         j3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774028752; x=1774633552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0++HSGeF8vukyIF9xdQ3UG+tReehtKpPJp6a6k4VKZ8=;
        b=FLBkKa+VxQkE8q+Ihlv/h6Fv6TmYc3G9AQ0p7sK25RKoRjLSISyNCVqj+kLizwNKWF
         tQmckGMdi/2MjBfARt1aJ2lfkKVpdvk5GuYtD76EfP07BPpZExCTgfoH9pdeQlTOyZ4Y
         ihNK6K2pKbtX0A8V1QTCQCmIFytEA4hjYFvnR3+fAYg6mAcWnwR2xq/UFaUF0DrBspmL
         OHWIka7XdzyREEG7bK69A/zIUlq32pMVrCDXFHZMfbKuqbzMKr8CZPD4GrZOAfk1s+B7
         DAT7y1lmfnlU+DKyVUoKmbYHkkeFeGX3m6KXZfS7GuIlj2v2OHwHSc2t3n0iYUAEPJuE
         hKVw==
X-Gm-Message-State: AOJu0YyPe8rh7H6caJIs2xZpW7YP9WztpKD5q6b9D7HcJh80zVllmMai
	aQdv9bRhsWhEnwnaVj/moKRHyRXjpG2QwzdJ4HGRT0aHjDDmmkN+4NtrVrlI5CL3wMpbuTE+/zR
	9TSrn5GpbvRDURTaBEv5DDrWmEizbzKMxpDOUgy2PpL4zH7x8sNupbbju8PlmUWHnluWcg6bfKN
	lGUItqYYP8xfROdehdPN5R49wRX9zqd+BEj2eivDPnf6hKJLcOtk4JTSg7amyTX95XuXajWREIp
	n4KLA==
X-Received: from dlbps2.prod.google.com ([2002:a05:7023:882:b0:12a:7182:6cb])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:388e:b0:123:2de5:346e with SMTP id a92af1059eb24-12a720ab433mr1511969c88.0.1774028752285;
 Fri, 20 Mar 2026 10:45:52 -0700 (PDT)
Date: Fri, 20 Mar 2026 17:45:50 +0000
In-Reply-To: <20260305015237.299727-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305015237.299727-1-joe.lawrence@redhat.com>
X-Mailer: b4 0.14.3
Message-ID: <177402875063.3545153.1306886249608000042.b4-ty@google.com>
Subject: Re: [PATCH v2] module.lds,codetag: force 0 sh_addr for sections
From: Sami Tolvanen <samitolvanen@google.com>
To: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joe Lawrence <joe.lawrence@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Petr Mladek <pmladek@suse.com>, Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="utf-8"

On Wed, 04 Mar 2026 20:52:37 -0500, Joe Lawrence wrote:
> Commit 1ba9f8979426 ("vmlinux.lds: Unify TEXT_MAIN, DATA_MAIN, and
> related macros") added .text and made .data, .bss, and .rodata sections
> unconditional in the module linker script, but without an explicit
> address like the other sections in the same file.
> 
> When linking modules with ld.bfd -r, sections defined without an address
> inherit the location counter, resulting in non-zero sh_addr values in
> the .ko.  Relocatable objects are expected to have sh_addr=0 for these
> sections and these non-zero addresses confuse elfutils and have been
> reported to cause segmentation faults in SystemTap [1].
> 
> [...]

Applied to modules-next, thanks!

[1/1] module.lds,codetag: force 0 sh_addr for sections
      commit: 4afc71bba8b7d7841681e7647ae02f5079aaf28f

Best regards,

	Sami


