Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C481DE2C2
	for <linux-modules@vger.kernel.org>; Thu, 21 Nov 2024 20:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732221770; cv=none; b=SCoLApQ7WpIyDlG31LI1DnOhKh1Hl8P+Elc1mlN2yVlZ/8yTDvadNk75qxKEIGJGkaQhOUy8FGcb0hNVES46HdgKiSKVp6YtL3cZfyW8PX95PceSlQ9GCMBcl+3UwIyrjfyyURL7PcejAlUnLlqXnR+2IuLBz2HgowRpJk/PQko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732221770; c=relaxed/simple;
	bh=aJnHoVU7AKnaZ23w+Dc4SlHAPIMvZ400/m3njLPupx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sbMcoQ4OZCc3JgnxxBFL1gG8a84bS3YcK0sZGRqqD8XbSrFY0GJy7O4Hi8s2wYRNbAONwyeK+dGNRsBmT0z8j31WO8TQPcAX9MTfmRV2qwSUqjv1BE1QCZnTfVmDL+Mp7zy2K1ZEezsP4KaW4K6X5t2eZdIt47bxtdYXWABykPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1SgySmAk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1SgySmAk"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eeb754bc7cso22048207b3.3
        for <linux-modules@vger.kernel.org>; Thu, 21 Nov 2024 12:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732221768; x=1732826568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7pZ/4xogXJ4cKm1OQ4EOa6mZ/jPcnYnoZlpn2PBS83k=;
        b=1SgySmAkoCFv1I756RgfYYU63O+1c86hLRMgFwySLVGBJRQBYmhZXwY4rSkIMNjgff
         IWwLarLU2iAICxrSF5QHzgv0avUGxdIRKMW2BlEVD3uOzBKhaojNrDMKM3MKWOwJfgod
         lij+nj/BV3DTpWN0CjpwsIwoWXos1wnCi6V7cb7Qyj5Zk1VRVBgZFVelGkvo4M4jx727
         USRFjrh5OW3Lq+7ylDy/zk8yrFTOLXIQUB0MwmQzTk2arnFrL66G6q06fvjZBsKxv9re
         2+BYlolhg6y9QPHZWt4MfiY6sSRUsNiuCrVNU4SHamJD48YwDb4TYOpabzGCq13QMS/L
         /Zyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732221768; x=1732826568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pZ/4xogXJ4cKm1OQ4EOa6mZ/jPcnYnoZlpn2PBS83k=;
        b=nvLHzj0lnauvCgECt5zjfS27J7b/p2z50pGh1WEuPEtsQhXy1dIX56HIM2FL7TlDE7
         5WumO6jKoJGbPmHjJ2PpobihPcKw7xhsZQj2X3a+LNRjuy1azxPWbrzuduEeKSU8M3Fg
         g1qQNvJiffzbINRLtiFt2z9jIGUNIPP0A03YD+/ErOp37sKLmHiJJJ8U6bYG2QT0DbyA
         q54JtMpb9Zhlf8nWZYeXzeSeZ0cjGNvzIoyRU4xzR+WLxTTpuHqGGuoxgcPdrXuu4cC+
         TENwr24o09mpQSPGon0JX1B1EBxH/pMvdnmRmCGrYAIYqUp57EQkDYHU6k/rD5Uz+flH
         BfPw==
X-Forwarded-Encrypted: i=1; AJvYcCXj76eDFGa8SPl0h2jC9Sz/Tft/+sOpzcuZgMAoqAOghhHt8+do1BpE1of7id5/fyqrhwvtNnLpkUIDuiTw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LQg6y1PIbxaIhnf2tiaLdeS5q3TS2eY5icf5+STmFhKysw7j
	EgPVpa91dp2NfJ2rc/yMbDb2BjJmHBcCibq3NglUGwyurgr5g9REl0V/bxVW7DnGqHpzSh8ZKK2
	PuVF0iG+arHggycVK3xootCYatQ==
X-Google-Smtp-Source: AGHT+IFUmYZ94k6o/pSgAkQo+n4cA2gB6D9v55LEtbY+hxIdzVqLBZoYtltcx5dTBWlE7mWKQXRUOqPQVTx6pAsX9dk=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:690c:2706:b0:6ea:7a32:8c14 with
 SMTP id 00721157ae682-6eee0a5b0ffmr28517b3.7.1732221767889; Thu, 21 Nov 2024
 12:42:47 -0800 (PST)
Date: Thu, 21 Nov 2024 20:42:28 +0000
In-Reply-To: <20241121204220.2378181-20-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241121204220.2378181-20-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2300; i=samitolvanen@google.com;
 h=from:subject; bh=aJnHoVU7AKnaZ23w+Dc4SlHAPIMvZ400/m3njLPupx8=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOn2sw1ikia+s28P87hiuTzQ7Zfqt4umt29sPjcz6ZPLn
 O7nqdZLO0pZGMQ4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEDs9j+J9WUDr3hulKz1Mb
 /qfY9j5l9ZnfY72hOYpnU9PrPj6T1esZ/gdt/7OCy6H72jpRvwLDOCs17piznqGdYu/md6TaHcv YzwoA
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121204220.2378181-27-samitolvanen@google.com>
Subject: [PATCH v6 07/18] gendwarfksyms: Expand array_type
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
index 7e6b477d7c12..ade9b3b7b119 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -219,6 +219,7 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
 	}
 
 DEFINE_MATCH(formal_parameter)
+DEFINE_MATCH(subrange)
 
 bool match_all(Dwarf_Die *die)
 {
@@ -341,6 +342,33 @@ DEFINE_PROCESS_TYPE(shared)
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
@@ -436,7 +464,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
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
2.47.0.371.ga323438b13-goog

