Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C31620
	for <linux-modules@vger.kernel.org>; Tue,  9 Jul 2024 05:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720502460; cv=none; b=T0bLSO+olgQKmls4mjXpqt147uHSqegnjFVjAX0rnrkYFoyIK+dOSuO5JQNJTBkgk2KZNyxHy383DtqpDZmxQemSor0LYTOLQt/j7ikJZDuwzTDQLU+fIC/L8VQjkdeUUhmgvC3Lvs7JfP5o2t89nK5yza74Tp8r5rsjRydtEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720502460; c=relaxed/simple;
	bh=Ffxb66OXXpaDSXvsf91iEqbXPV2zoKVNjmr/+GSrvjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DiixE8IgmZXyZmmatdyTMaijvfeI93jaVWnKsOj3Cybe2/1nt0+wu6bBBOPXdWi4Gkdl9s6B3Is/tC9ulVdSiO9lUZsplZ47fb2DCAqtpPKZ0OgFNqzC2MSdb5xy4X33/N9iG9XnB9iQNpQDAaG47E6P09F8K9qm1wBcU4npYsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PBJ14Xwy; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBJ14Xwy"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-79f02fe11aeso186752785a.2
        for <linux-modules@vger.kernel.org>; Mon, 08 Jul 2024 22:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720502458; x=1721107258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKNsbM3GPwp7/TmhU19CnobEVglxGjJavT9dlt88xzk=;
        b=PBJ14XwyD7m8d/0rT7m1YNEL+lWdo/Hc4FOv3FW2ZLnXZhmYv1DA4nTJ+PfsJqLKR6
         IriWQcyBJy7dQJtkUU+3/aBfHOi15b6DSnBexqYOCDCq7JAsVDaU7CHzmaDtPNrPS4zN
         D4NgdsXtuoPatOor2v0P/cocUyuxdMwMXExICdxyRlMTedDVvjB2sKI2L7GU0AgHZ0W3
         LanMcB23qU2pbk5vQgs9y/Hw+Hx90tCxGH6SeAQ6Nk/qFGoLNmoUamGBxsqupPYpUzcw
         d4Rlr4b+FaKN+rYt7VYDoZK65hg/eRtsoNwTEV67nOQiWb1yxEdsgTw2mnXmfIMpLLDd
         XYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720502458; x=1721107258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZKNsbM3GPwp7/TmhU19CnobEVglxGjJavT9dlt88xzk=;
        b=SMDHADuDLIe6qliW8mjcl9DD0Ti1DNzjTrm2+R2oZTYFq+IBKVvhEFnjGjnwmjEhxB
         xJKmSScN9mnNJOjjNIoQsXQzm29J1UvC21LpeGGQTYZwwcDGMovS9/x4rpN9gLWhqFOf
         nFyBsilppuYX057CsqwlZeqQo8UiK3HnOdPNjrEpLH7gkWtZgFBmlbii+nNwrEMLEyeC
         n3TStt21A21jkxgmDq4oJMZ0+qnKWbfqcgWvlz1bTsaVAzGOVZhLHbTuL9n0sH42BvzJ
         qJdyh9RHGEg1xkwsqrDH3ghMdmpupairh4UDJAuDqwEiLSPZdUtrrpUCs2qH/xwMTFp2
         7bAg==
X-Gm-Message-State: AOJu0YyQvipBfnD/RwJvkTL/yqPNO2C4iGyJh976Y/y1Lbu9TkyNtD3H
	hsOvLISTQ47TUO55PdgWkbC175HRiXg0mi3gpfDFqd18bfmMMq+3xbNtiw==
X-Google-Smtp-Source: AGHT+IHFEd0aDnhvYftpsVAqb2yeoJdG5pQcSZKEsE0VhEAX6FoYyLDsr18BFcaHkzKO9NFPiXfq8A==
X-Received: by 2002:ae9:e50c:0:b0:79f:aaa:ad2d with SMTP id af79cd13be357-79f19c09fd0mr173696785a.69.1720502457740;
        Mon, 08 Jul 2024 22:20:57 -0700 (PDT)
Received: from ldmartin-desk2.intel.com ([2600:1702:4eb6:3000::3f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902bdf5sm60544185a.66.2024.07.08.22.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:20:57 -0700 (PDT)
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: linux-modules@vger.kernel.org,
	Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH kmod v2 00/17] man: minor improvements, post the scdoc conversion
Date: Tue,  9 Jul 2024 00:20:55 -0500
Message-ID: <172050244024.75910.1843250455969178165.b4-ty@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240708-man-v2-0-a23df6ef871e@gmail.com>
References: <20240708-man-v2-0-a23df6ef871e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 08 Jul 2024 14:43:08 +0100, Emil Velikov wrote:
> Here is the remaining patches from my scdoc series, re-spinned with all
> (:fingers-crossed:) the comments addressed.
> 
> The series includes:
>  - patch 1-5 - trivial fixes as white space, punctuation, etc
>  - patch 6-14 - expand documentation around {depmod,modprobe}.d
>    handling, remove open-coded .d and .conf references
>  - patch 15 - remove "maintained by" references
>  - patch 16 - NEW: replace all AUTHORS sections with suggested snippet
>  - patch 17 - list short and long options on separate lines
> 
> [...]

Applied, thanks!

[01/17] man: add some extra bold/italic annotations
        commit: 134bf30e7493ae50ad31ef5d3767174505eba4cb
[02/17] man: white space fixes
        commit: f1e233c31edb7d45704d2c7e7563ca9e8891fb43
[03/17] man: misc punctuation fixes
        commit: e971579bba7616cee3e13efa5ced7682fd395739
[04/17] man: some options take an argument, mention that
        commit: 2b5c56c43026fba590aa866074964ae79d6f49ab
[05/17] man: couple of grammar/language fixes
        commit: 6f80a0874bdbcee17c26750ae92a5bae52f0ae45
[06/17] man: stop removing DISTCONFDIR lines
        commit: 52a9d424649cab905fbddd6013eca5fe9c89b40f
[07/17] man: depmod.d: document the config file order handling
        commit: 12ca199bd771a5bff17d6ae73fc23be277ccbaf0
[08/17] man: depmod.d: factor out a CONFIGURATION FORMAT section
        commit: 0682f1ed56a8f7c681798c720436b2ec3d028d4e
[09/17] man: depmod.d: rework the opening description sentence
        commit: 7b19a71289198beac8fae9bcb8d5bc176edb21f2
[10/17] man: depmod: remove hard-coded /etc/depmod.d references
        commit: e83e142ce7eb2130cbee16771129482fefc36478
[11/17] man: modprobe.d: document the config file order handling
        commit: 11d09ac414bd706ea4a7bf923240655909195da4
[12/17] man: modprobe.d: factor out a CONFIGURATION FORMAT section
        commit: e46b473a92c776c84f74e984dc05ffe0ac921a7a
[13/17] man: add few mentions about MODPROBE_OPTIONS
        commit: 42d60a3267162a36ec6b6b39a7b91e5078b90979
[14/17] man: modprobe: remove hard-coded /etc/modprobe.d references
        commit: 4ec655d249c804b5394d63f0f04bfe5c94ab7031
[15/17] man: remove the "Maintained by" references
        commit: ff38d82edeb113b22381cf4d0439a041f64d12c7
[16/17] man: rework AUTHORS section
        commit: 082617913f68b0363e5701e470f2b78786dd9aaa
[17/17] man: list options one per line
        commit: e7626810fd0f34db2c205b86ff6ad6cf42794fa7

Best regards,
-- 
Lucas De Marchi <lucas.de.marchi@gmail.com>
