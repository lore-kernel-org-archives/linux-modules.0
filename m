Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086C212F12
	for <linux-modules@vger.kernel.org>; Tue,  8 Oct 2024 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412734; cv=none; b=W/D0nAgtw76yKAiT3qENdpWJjT78snIrt30Nf6bgCpICUFIduEV4XwJ+BMt6JGQ7CcUCCToKm2095gVA6UdR0TJ4+OKXAhbvyNZcV/6zY4QVLPwR6ZPBjaeTloyQ9iTbVKZ2KW6+1D22vz7uJxGB68XXnDcxO7Vqw2UzjKBb878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412734; c=relaxed/simple;
	bh=mITPyravUpQ/bJzC6y0bi7OfUc6olmVCmSnsnJKAM7Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nvR9up0UKT9sTdRQ/JE6ShRr9QUuQJ4xxw5Sopfo8W+CknFX5FfAMSYYlxh0M9tvhCFs3cLI5Xv0a8upq80V354FzqzYBT033XzJaP9SFj6t9u330QzvC73UtD8khcsyOu0PP5GblkgJ8d2b6ymb6UUUIUjfUGSA7cEmzPAmEco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tEISiiuW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tEISiiuW"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7b696999c65so3735002a12.3
        for <linux-modules@vger.kernel.org>; Tue, 08 Oct 2024 11:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728412732; x=1729017532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5IN83f2AWDRsPM4oFeAVwXzABTM6F2NmuC5qwi5gGYs=;
        b=tEISiiuWIUNOtRULQhl0rjZEdoDCXhCf5jCLqDmupCoaKupmgyG3dOyqH4mZAI+RE3
         +baTtLHU+0gYSg/frMz+Vs/ahssg3NsGvgc/j2V5lJY4AwrArckK+y4dEqJfF4H7uuXx
         apGh0MTIcfJBJ3+6PLJ/eEue7zNrBfQo94aGqgi3rVLhvXphvFSoVbcyVcHo3OEHOXZY
         NF/dsrLW1iVjd0bm1txpCla6oitZOCzHzn3lslFfDiWaB0zW2HWLvzxLF0LsML8vuEm6
         cij2s74ILpPYnmO3U22c7q4y8Zi5yGtTAwckE7nWVye2XOaqxNCM9+ENwtFyI2+Y1WlZ
         eHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412732; x=1729017532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5IN83f2AWDRsPM4oFeAVwXzABTM6F2NmuC5qwi5gGYs=;
        b=U2AO1d2vYe0hHLRdT6eh4mU3dJftnK2Ax53dt+r217GMbtiPDoGu9aLJWxAJVvpKe0
         2QpqH4FkY4JljVmbDlFIZaGEdPbkdvhR2M7EbOSE8482wy/r8XOZFKy5X3RHcjz4UWEB
         ThaUsBx0frrv5usRdbLt9wzbKwqMdH84yau9hwp6OIHF6OTVLNWvQlJwqyBSdxKguygr
         6END3DM+GB+th/OTrLLP9bmkA0A5ZUIMZ9DQqO75RMbpmUljuiYW9l3yUZIdny5u652a
         BrUHGKiYsxduO/etHnVVx0bibjGM1ET6gwhlBPu6aiDtQ6D5LJyAlE0J0z+Olqdk6fxx
         DDVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzlj76uKlEY8rGUt0ImfWt4B1Bm+wjQIys+KU0sB8Dtn+hGupFmq40oKWyAYMKA/vhkFLtqJ3ZCLHmq02a@vger.kernel.org
X-Gm-Message-State: AOJu0YyZJLMTDs2y0x4ZG600LZpUhriazXqjGxqQoK/2EhvCHvuUBoQp
	+XWHxjaoRWPfL2ULcZv/pw+K2Y6XvCFMe/zbZ2twAS0GNFdTIlKT5YHCmsradtw1hmOh5Ss0cuK
	nrf/OZML+UfzwukeUvW+RSDahlA==
X-Google-Smtp-Source: AGHT+IFTrAucXWOZ9cZin4iLnAuYNLU0EypeB1Z89LIS9DMR6Ty9nh8TVw3+ALRwnadMOVxAECwEdv5BsoMa/bUsExI=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a63:6247:0:b0:7d5:e48:4286 with SMTP
 id 41be03b00d2f7-7ea320e1a64mr17a12.7.1728412731505; Tue, 08 Oct 2024
 11:38:51 -0700 (PDT)
Date: Tue,  8 Oct 2024 18:38:32 +0000
In-Reply-To: <20241008183823.36676-21-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2343; i=samitolvanen@google.com;
 h=from:subject; bh=mITPyravUpQ/bJzC6y0bi7OfUc6olmVCmSnsnJKAM7Q=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDOmsNSotQRLVu8W36TyxnBn03Kh8W8wLl9zpO/6c+5uir
 zeHSyygo5SFQYyDQVZMkaXl6+qtu787pb76XCQBM4eVCWQIAxenAExk5xJGhgW6sTfmOap9F+2d
 dj/kZfa9k0X8vx0SbpTtlLaVf3TpRTsjw0IVqdWfXtzz9zknuvFfs55LlIl/QB73x//S4bUObNb L+QA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008183823.36676-29-samitolvanen@google.com>
Subject: [PATCH v4 08/19] gendwarfksyms: Expand array_type
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
Acked-by: Neal Gompa <neal@gompa.dev>
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
2.47.0.rc0.187.ge670bccf7e-goog

