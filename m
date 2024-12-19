Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3414C1F192B
	for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734642484; cv=none; b=f9iBVQJo2E3YpHIhzrQl3kt2TuQxzI7ZIJkb7tJd0YM66W/sz9Es8e00ciHjx2MLnIMgY+WK16ISwk6PL3VddwbQumCRfIZ/rt5MHogqQ0KKon1ZS7O8Z6bDRbNKD0ERhUJCPiBOfbvsITWFvcHT75o6Z5z8ikdnEutaaLhvqYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734642484; c=relaxed/simple;
	bh=V88Ux5YpLtipLnwT7oAorrJvHrfCrHoGnWDZa7njhBA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aGtxJ5HM8xAB+JXXJ3V9ZA6Tr3If9kRK4Kr0Jjt0NiU+sq2CEA0DR/Q6bVeFs/JAC/g4ZRqJN75H7j0XliLcMnjtHIOVJ/hlugprnXAaGswwkk+HYAy438aIRGNoL0y1kpfl1xhLk/SJcFQ5V5CHUVnOnDPttgeiznbOzzoSRjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SNRaDN42; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SNRaDN42"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21632eacb31so8707955ad.0
        for <linux-modules@vger.kernel.org>; Thu, 19 Dec 2024 13:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734642482; x=1735247282; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=12wMWYmdUy+3imKc/VOk9UykTDeV6/VQokbuwTAWfVw=;
        b=SNRaDN42AjnZ0RJlXamPKfrgzp83iOyx5fdEAaKCevNY15riTlG7Oyr2go5bWuqjp0
         oqUPxO/q3cZKnZeoxb69PpRq5bM6NCwHsOCZSryMz/PvloTrvygM7Vr9HZRZK7y4Xwf4
         +W0AE7Kv2oRdtg6Y856vR3DVYMgcy7oTJqsX2elPpEniK7SebNAeQpyb9B3ARzN4nATC
         75kBc4mtjH6xnEy6rp2YjVw1bTxRJPvld17uN3miGA6ddlU0rA+Q8MzC7EMlgdf/8IZL
         bHFfC6MzwPa9cDFY+xgxnd4s9gE/6GY8rxSFJiuiqpe5wJwQB1wYEcbN6gpAH3JWgsU3
         omjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734642482; x=1735247282;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12wMWYmdUy+3imKc/VOk9UykTDeV6/VQokbuwTAWfVw=;
        b=IK+3ofZu33W83LLiAkinWPPYYrGprY65jZUU/N18t3YV7qcuIwx7D33VbMOe1+Td7X
         BTYkJ9EaQvLJjokS5Txs/vMliDPmpu0fzFlhm1DNGUvNKl1zteN0ifIc+isRZ5/719wn
         rPY6X310THhh2l6BQVR/SBYiuCZLYMYo2efGlDjnc47AXO1T9j8JaHDlzyfNs8qzgMBv
         tf2VNgpLptAgc8ro0egsemm/48Rn90+hHEKpg4UWqAuhRlfy50SbRHMxFURiqoX0Orc/
         1353DSwrIHgn0pFdqryWnjC1Diw2oNbBv7qptFzMoeIIgRk230FTSpHkT5byeQShvHYn
         yf8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9p5LiD1t5aumJ2ipEhXGmttk4xd0S6Pc0AOnwRzokkQ1wmVEkVmXCXpaSxc6bItKJ8niPO9BLaIyIgfCt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw43yfTNVpCnU6T6DxU4VWhYFbGojVDNIvi0ZX0pbhmeKdnyOnF
	9krRvxnImgpW6sfZ7qzaCh90tbycAIwthnDAVaoIrvhgpQbGg2ePET+xB98AHSifdzxKHBalX0z
	TvjERwYOGWOqFMJdQVomyvMQ0ug==
X-Google-Smtp-Source: AGHT+IHZrAcneZVhNsCIJl4OSOoxoaOpAg9w4VYA1++o7u1kqFXGpYUShSf1O/vsRV3hJwyf6gqPsZGiC0raVqrtViE=
X-Received: from plbkw5.prod.google.com ([2002:a17:902:f905:b0:212:71c4:23f6])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f610:b0:216:3436:b85a with SMTP id d9443c01a7336-219e6f4319fmr2835485ad.52.1734642482229;
 Thu, 19 Dec 2024 13:08:02 -0800 (PST)
Date: Thu, 19 Dec 2024 21:07:44 +0000
In-Reply-To: <20241219210736.2990838-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241219210736.2990838-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=samitolvanen@google.com;
 h=from:subject; bh=V88Ux5YpLtipLnwT7oAorrJvHrfCrHoGnWDZa7njhBA=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOkp3TLvp/H9tv5kvenc6S9TLjAISJ2d27a1NzJd4Onzq
 8Lz2vjmd5SyMIhxMMiKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJLL3D8E8/w7dtVYumj1ed
 wCWlAtVXLxNT3+XL1y6a8osnLTDOMpThfx4HT57ele1uqz8KPelavWCaCu9ul6uPlhRPljufk1l owQIA
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241219210736.2990838-27-samitolvanen@google.com>
Subject: [PATCH v7 07/18] gendwarfksyms: Expand array_type
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for expanding DW_TAG_array_type, and the subrange type
indicating array size.

Example source code:

  const char *s[34];

Output with --dump-dies:

  variable array_type[34] {
    pointer_type {
      const_type {
        base_type char byte_size(1) encoding(6)
      }
    } byte_size(8)
  }

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
---
 scripts/gendwarfksyms/dwarf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 7d8a4eb6c387..46ce17b2459b 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -220,6 +220,7 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
 	}
 
 DEFINE_MATCH(formal_parameter)
+DEFINE_MATCH(subrange)
 
 bool match_all(Dwarf_Die *die)
 {
@@ -342,6 +343,33 @@ DEFINE_PROCESS_TYPE(shared)
 DEFINE_PROCESS_TYPE(volatile)
 DEFINE_PROCESS_TYPE(typedef)
 
+static void process_subrange_type(struct state *state, struct die *cache,
+				  Dwarf_Die *die)
+{
+	Dwarf_Word count = 0;
+
+	if (get_udata_attr(die, DW_AT_count, &count))
+		process_fmt(cache, "[%" PRIu64 "]", count);
+	else if (get_udata_attr(die, DW_AT_upper_bound, &count))
+		process_fmt(cache, "[%" PRIu64 "]", count + 1);
+	else
+		process(cache, "[]");
+}
+
+static void process_array_type(struct state *state, struct die *cache,
+			       Dwarf_Die *die)
+{
+	process(cache, "array_type");
+	/* Array size */
+	check(process_die_container(state, cache, die, process_type,
+				    match_subrange_type));
+	process(cache, " {");
+	process_linebreak(cache, 1);
+	process_type_attr(state, cache, die);
+	process_linebreak(cache, -1);
+	process(cache, "}");
+}
+
 static void __process_subroutine_type(struct state *state, struct die *cache,
 				      Dwarf_Die *die, const char *type)
 {
@@ -437,7 +465,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
 	PROCESS_TYPE(volatile)
 	/* Subtypes */
 	PROCESS_TYPE(formal_parameter)
+	PROCESS_TYPE(subrange)
 	/* Other types */
+	PROCESS_TYPE(array)
 	PROCESS_TYPE(base)
 	PROCESS_TYPE(subroutine)
 	PROCESS_TYPE(typedef)
-- 
2.47.1.613.gc27f4b7a9f-goog

