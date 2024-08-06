Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC113E881
	for <linux-modules@vger.kernel.org>; Tue,  6 Aug 2024 21:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722979276; cv=none; b=EGmEj+uq7k6fj7egZgU+fmkm9YgTr3HhF2oyuDbYgG4KUAyLL5Kd9qGxdSGOBMWv4IoJr2hqGXXd8f/hcMkiP4xfk7Gp7Jdlt/uoN8CwbI3LMTxMjDlSfPey8FQn8iy70CLV6wqPv8pUbuutUBcHCPiidPotN/dnJDOPbh6tj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722979276; c=relaxed/simple;
	bh=iji02Oc/3eVse8/8b0a97tqkHPOd2ny7+/1oh5B8hHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fmlEclTMlDLJLX/ZgW3pAQ1elyP9yCI+ZdsEeEolNHy6gTSxMdlKV9sIq6vXOosWKy4XZ3B/MW6/+V9zN4qVuGhIRcKBNHG9qnF23Km9dfm/gSuZ2C53uh/8/K7apQXekvKqVecZCQfN1ypuLOEJjTY8f6FUz7aI9ku2Js/OWqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMR8GsLr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mmaurer.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMR8GsLr"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0ba318b1b2so1807195276.0
        for <linux-modules@vger.kernel.org>; Tue, 06 Aug 2024 14:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722979273; x=1723584073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jOl8CtEcN1RVp67UAYoE5SQ2BHxlCocLL/lZKU0oS64=;
        b=sMR8GsLrWGGLnAivD0/ZcacpSVIAT+HyrCJr80Ljsgb+akD+gu0IyhTaRPMVbRCOwQ
         e29Km3ZQI0bm+x05zroBtWzX07TIXLAcGyeDLoQiBYtddkf/TO1KZwjswxtlila8Nyqi
         mZbCjf/GGXUanauQs1mzDSILPh2h5e+XpQV6VyMTe2djpqs5qacmhEuD5JkXhCT2Llc0
         gBga8E4G+3s3M2jZtVWgdJMcNxy95wSE9E37NY+GoSuD1gyh/LtDgtz85emICnvg8d3g
         8TtXaCp5Gi0CLB6K1Y61NlKDXN7borzFDdwip7Tc2ASj+IHzVzaHhCnjXmYl/TEIL0cS
         aHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722979273; x=1723584073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOl8CtEcN1RVp67UAYoE5SQ2BHxlCocLL/lZKU0oS64=;
        b=CQhtnuOL/h0VF3ZuMMrnwW7ndfknQGepI89Bk50DS1hijzNl0g8UbZmTnGXJJHW/6Q
         revWqkM/RlFdWWtOmr4g1JKb46xjmp+e9S50F88ue5OiEpYwqdp9p4daqQYgKvEnkgCI
         Q3KcBRJzIYrc5XqWypausd0FD8QEzNTrErk6FrVMoQv5xq+bJJjIC+KyCJckJzqiWk8Q
         +dtXjhrhJpf5YyijZBuLOWWSryOicR3qoqseACi2hIq93aznIlV5d+2RW0lgTzuro/9m
         /kVSzO4I1X8Eso38l4TGtqGEt/1eLhDeRNFINL2abma7VyZf2JFmiCzr4USoHpqqHPcv
         BdKg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHBzFsI/i5sc+DoHHZThmQRXY572GLQZ7RMgs5MVZkHyiWoScxeVpL+PcuyS8RHJG5INdUNzhXSwGhJxavBDagbDckvHliwTJIk6dUw==
X-Gm-Message-State: AOJu0Yxg1TTglwzStgHVuiD8fUq3IS/eQ8U4BSfRGeySleG+ylw0iTMp
	c8LFXWqDhhilsgM5d37PHpQg2YwUgMWxiiiwx9l8tGLCM2S+emJn7PngOBLfwkvfk4ws0TCqfBo
	14xD3MQ==
X-Google-Smtp-Source: AGHT+IH68bwpdjlnY26x/2+wcQZQXwD9UHybE1nA22cklT9RgpSzraQUX4QVqW9CAA8bhLmB1AIfRzUuzphh
X-Received: from anyblade.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:1791])
 (user=mmaurer job=sendgmr) by 2002:a05:6902:188a:b0:e0c:301a:1d8d with SMTP
 id 3f1490d57ef6-e0c30666c8bmr256479276.4.1722979272769; Tue, 06 Aug 2024
 14:21:12 -0700 (PDT)
Date: Tue,  6 Aug 2024 21:20:27 +0000
In-Reply-To: <20240806212106.617164-1-mmaurer@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806212106.617164-1-mmaurer@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806212106.617164-2-mmaurer@google.com>
Subject: [PATCH v3 01/16] module: Take const arg in validate_section_offset
From: Matthew Maurer <mmaurer@google.com>
To: masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org, 
	gary@garyguo.net, mcgrof@kernel.org, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, neal@gompa.dev, 
	marcan@marcan.st, j@jannau.net, asahi@lists.linux.dev, 
	Boqun Feng <boqun.feng@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`validate_section_offset` doesn't modify the info passed in. Make this
clear by adjusting the type signature.

Signed-off-by: Matthew Maurer <mmaurer@google.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d9592195c5bb..141a964b6b13 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1645,7 +1645,7 @@ bool __weak module_exit_section(const char *name)
 	return strstarts(name, ".exit");
 }
 
-static int validate_section_offset(struct load_info *info, Elf_Shdr *shdr)
+static int validate_section_offset(const struct load_info *info, Elf_Shdr *shdr)
 {
 #if defined(CONFIG_64BIT)
 	unsigned long long secend;
-- 
2.46.0.rc2.264.g509ed76dc8-goog

