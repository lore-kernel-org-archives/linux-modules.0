Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A607326922
	for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 20:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766435102; cv=none; b=CYB8zsJbbjDU4xWjPCdF/BqLab6YKEJLDHLjR05GYWKWscyXBNgUi1Ww2Ct0dUjTuaHvWNytqBKjAdYHgg+u5xyA2+UtK0l8J2lXoPDlVy+FTi8X674+7pUdsgsECaF/CunCGNEsgMh/BG3ev4A2GHFBKTEKH91MgDLRCVGGzYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766435102; c=relaxed/simple;
	bh=v5L5gXDnVlWWfiv/G0jR9HkitiFkU9QX4orelWuzcWQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j1v0B6l8wf+LQrEFpMczCpn4EtTF21QqFoYcvNw3+xBYqPubhwNB07OLaCQY2Swp9Km+fRwQTBAt/aU8sJ7TZdW95v3onjgvDgjYjZ83Mucijhy6Blomxba682P+iRhHoc358e8zAxil9D38OyNhYwioFcvLDBumFAWRs8L/L84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHW1SH2S; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHW1SH2S"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-34c21341f56so13075971a91.2
        for <linux-modules@vger.kernel.org>; Mon, 22 Dec 2025 12:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766435100; x=1767039900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuWaprUrnlOgZKm0tgBiLASfxj+4f7HgxNxIOgXEExA=;
        b=HHW1SH2SEeeAi4aiVTQSRdh315LKzmuxXJHvtq3SrKuHxz2RHzVqXaKBJVG6ikPN9D
         ZjyVZMiMHBpKrqNfOCZZZdwiChRCNvCkjZAFCi3SpxUe94oAFs92aXojfsSpruEhs9nL
         2IOScocFkRhBWqcA9WWlBxaa75Fm8iCS+E1B9aYMb1/TR90FanLHzvcZ5oa6X1LFRkZS
         21bRvGfbaNolcRbjnFzvBMmK8TTNGeVs1T5PRzU+u5hIE/tdKcb7OIW13CcyniXS68YU
         GNS0Q136hUcfqqcyuosHmOz4BTpy0S/ACv7Q5tJpVQmGjoj25DyMaODscpUZo+EluaAd
         EzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766435100; x=1767039900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HuWaprUrnlOgZKm0tgBiLASfxj+4f7HgxNxIOgXEExA=;
        b=kOXfpyF7uXlqR9abrK+7s+vvDjPWhVFkEGurI6FEyjRDTyE3yODg6TpN5EO9kneoXS
         mtiQyG5lA38p+TQ0vSLdX1N0uVQzPM+C4QJ6O2suTlzYN4ggG1Te3xyg2qpFV/auAEC+
         TuNLgpL2HFJKh/6BaTeMym0HJgMOdLIgfHAerVtvOGo/9JsxfWQeNf9CkbMOjb0curCn
         pSElNvpgyDUoyNv0Ft04yJY0kJtVjz1HrA/2o8gQO5WktRM4C6+eECjyYK+6Ybg9oJFo
         QyT//oPRQI9o75nv62UMQJgt0haO5POf9yqoOCmvtgoOIkt2r88+R7WklZP+cErPCQBT
         8TmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF/lM4lx1wzVUvlqpgNfoxWijn6Ol8nZaK97OAUltApC96uY0ZAXksPMHbeqksbOv1G4zfNj8v+JOqq4bF@vger.kernel.org
X-Gm-Message-State: AOJu0YwH79rHBM5mKNkzEJt6Ano1C5ZAsf0p7F35ypaBNheJYWr3351f
	hHdbvSjT/aB+G5QCReNU9Wvb757q6ZxcbqR9rmR2CFqMSozWQSrgkSL73NYG9/MDZzZLfL5riZg
	g3DU1uPIeeNv3MI7tgfH1c5cNbvgKnA==
X-Google-Smtp-Source: AGHT+IHpZldovjvPuErGikdSozVsC9feOQjMc7jisWWFzLGU223FEkoZUn9LlOInMQ9+NWqzMmv7xIAzFYE7E4H45lw=
X-Received: from dlyy26.prod.google.com ([2002:a05:7022:69a:b0:11d:ccc4:4c98])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:7e87:b0:11b:c1ab:bdd4 with SMTP id a92af1059eb24-121722f9176mr12101825c88.38.1766435100351;
 Mon, 22 Dec 2025 12:25:00 -0800 (PST)
Date: Mon, 22 Dec 2025 20:24:18 +0000
In-Reply-To: <20250819121423.460156-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250819121423.460156-1-petr.pavlu@suse.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=625; i=samitolvanen@google.com;
 h=from:subject:message-id; bh=v5L5gXDnVlWWfiv/G0jR9HkitiFkU9QX4orelWuzcWQ=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJmeK74abCpR/x+hYLn6jcaOpWs5THOs5kRwPv09hX+a5
 kxz+61XOkpZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBElmQwMhzZcGEu29RKm7iz
 01iMYwV/KEhMZtUv/7BNKO5UdGfp12sM/8y2RfjWi/XFsS8K31T7QfD7A/GpJqYKzQsfvrJ0um3 jzQkA
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <176643400570.1902051.11528101077941161890.b4-ty@google.com>
Subject: Re: [PATCH] module: Remove unused __INIT*_OR_MODULE macros
From: Sami Tolvanen <samitolvanen@google.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, 19 Aug 2025 14:13:37 +0200, Petr Pavlu wrote:
> Remove the __INIT_OR_MODULE, __INITDATA_OR_MODULE and
> __INITRODATA_OR_MODULE macros. These were introduced in commit 8b5a10fc6fd0
> ("x86: properly annotate alternatives.c"). Only __INITRODATA_OR_MODULE was
> ever used, in arch/x86/kernel/alternative.c. In 2011, commit dc326fca2b64
> ("x86, cpu: Clean up and unify the NOP selection infrastructure") removed
> this usage.
> 
> [...]

Applied to modules-next, thanks!

[1/1] module: Remove unused __INIT*_OR_MODULE macros
      commit: f13bff1b6d55de341f37a24781df5a1253377db3

Best regards,

	Sami

