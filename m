Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F9B26FDA4
	for <linux-modules@vger.kernel.org>; Tue,  1 Jul 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751383226; cv=none; b=GIXcWDKAJ0hmm36tSBg0/yR3CAQ7ePpxIUQFGsKE0UNfOF/b56QjXWp/uK3gEZAZI02WkEzucES6Vx5yv1OF9pOWBMsV/FQxZW4z2sks5nt7Hr9ZHS5NABphtuQocpbzJmFaGxfgPg7Q4RtwgaOxcC0ueLViSyFKUyuCdQfpCRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751383226; c=relaxed/simple;
	bh=4HxDKDVDuqVFjjRQfc2NTTjXMx7SXDrod/9PZy2w8QA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWvkV7WAPAfX/wWYK3RBVo8UuTh3kgpN/WYSXpMHauBRYTOYe/lvL1j76FChja3wuMFgt9KG6PtvEDD/cItDOWr5X1hbpzOpMN6gl77Z2XcublCl6MYKc5pbli2oUeuIWSSFF1PHKcTlxO94c6xmD1D76W1Q4IR33XIL1fFKJDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QQxqQFHV; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gprocida.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQxqQFHV"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f6ff23ccso3882345f8f.2
        for <linux-modules@vger.kernel.org>; Tue, 01 Jul 2025 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751383223; x=1751988023; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HS0leYMDlHYokYSQ7rOzdx0mYa3EoAXRbAoaC0gzq8o=;
        b=QQxqQFHVsJA3LIg146JX0V3i8xK8uLjncfhhNg2/xvlaH0sRbI946Y7q46aoJuExkr
         FrXctz80G0HaYUe+MivuMKrl6Z3tzzJKUHvJPjhBg8haPDjDLcmdQzra+AsvJYzHNc/D
         w9b+3z/hp9i4I5HSM3LyKRqZuIvymj+5K8tUj7QheTj9gYFXzdCnlu4rbO+ugYAfnciI
         xUu/ZSyL7uDz6Rf4+/LCypO86D6YVocLGTco8X541wZgM04xpKgwulkyhYAfXEOfbqKj
         uuMMzCf+oM/gQUCWev+Rm/8LzrVRV6rNttKvgTGO1GFuKtHFvqRvB++XU0mt0DZdq18L
         VgPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751383223; x=1751988023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HS0leYMDlHYokYSQ7rOzdx0mYa3EoAXRbAoaC0gzq8o=;
        b=Xs+3gke7UVBgVdVZLAlZiu6FdENVzeGDtVp3DG6T1oT6ujbH8GBEqcPAcVMF6d/7X8
         3vPrMRWcb9j3ezKlUEdI4bH376YI6vHI+WCYweulyw9UXlNQ9vu7Ti+MhOutQDiHKsiS
         ahMvDU/GVsr09ukdy8d4WheEB3TFM/3s8jVaCl2jpDHUsekMK1ao0CNE92y67OLwV1Kc
         0ArBeZcVRwx4DkCADJhTST6sb9U6S86gAPHPrOhZH0omme2uuwYxEhXlTRTMyR8fAS7N
         5MPhZS72OKV01HeAwvy/T/1+jRoueRiRe6O0pBlO++kSrG9iMeSp9FtOfuXVGJi+Dvkg
         CmOg==
X-Forwarded-Encrypted: i=1; AJvYcCUzSbSVR1Xp5rIaFR66n3w2dUEcIN9SBMLFFvelUEfRQh4ek3nxsQhrIubyXpQJxpZK6Qmv5ohfLxzQBgun@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yZ8Oc/KKVqIKCBPt3aHgadpVXHFjSJ65NbsE54nSs2HkminO
	Vwliychik36n4+lj+AUnwe74nCpEXT3oEK6v89d6VAQFhtaBN6qMe5bV4qjcoo5IaB/XvfJmiBZ
	NyyGBV7I4swLa9g==
X-Google-Smtp-Source: AGHT+IFnMJ61wTYiwe+Gnktsjz4/HaiRP/F54x21/++tHXd37+SoOD+fZukTxHtrkdZFAOLWvY//EsBG9SDmAQ==
X-Received: from wmpz17.prod.google.com ([2002:a05:600c:a11:b0:453:8b14:6e0c])
 (user=gprocida job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:42c1:b0:3a4:fb33:85ce with SMTP id ffacd0b85a97d-3a91818bae2mr10702455f8f.46.1751383223349;
 Tue, 01 Jul 2025 08:20:23 -0700 (PDT)
Date: Tue,  1 Jul 2025 16:19:09 +0100
In-Reply-To: <CAK7LNASzE1CtRo9T4byPXJtB-HtuWsGe=OLba+8JU9fB28Chow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAK7LNASzE1CtRo9T4byPXJtB-HtuWsGe=OLba+8JU9fB28Chow@mail.gmail.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250701152000.2477659-1-gprocida@google.com>
Subject: [PATCH v2 0/2] gendwarfksyms - improve symtypes output
From: Giuliano Procida <gprocida@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Giuliano Procida <gprocida@google.com>, linux-modules@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When investigating MODVERSIONS CRC changes from one build to the next,
we need to diff corresponding symtypes files. However, gendwarfksyms
did not order these files.

The first change in this series makes gendwarfksyms code conform to
the preferred style for the size parameter passed to allocation
functions.

https://github.com/torvalds/linux/blob/v6.15/Documentation/process/coding-style.rst?plain=1#L941

The second change in this series ensures symtypes are output in key
order.

The series is marked as v2 to distinguish it from earlier versions
where the changes were posted individually.

Giuliano Procida (2):
  gendwarfksyms: use preferred form of sizeof for allocation
  gendwarfksyms: order -T symtypes output by name

 scripts/gendwarfksyms/cache.c   |  2 +-
 scripts/gendwarfksyms/die.c     |  4 ++--
 scripts/gendwarfksyms/dwarf.c   |  2 +-
 scripts/gendwarfksyms/kabi.c    |  2 +-
 scripts/gendwarfksyms/symbols.c |  2 +-
 scripts/gendwarfksyms/types.c   | 33 ++++++++++++++++++++++++++++-----
 6 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog

