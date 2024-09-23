Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249C71A2C23
	for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 18:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115564; cv=none; b=uOjBXrwcaCpvOmlYXqWbjtim5C/Si0Z5w3QO49X3MqVx/K9cTivXp4RkQZiLKhYnYCnudpW4AX+qjjLnH5ap8fXaLg8wGSsv6cwGiAiK21iAElS5zplzBBNrt/SXb9+MVsj0akaNXmJNAFN4ckzk91itmk4p1emZDhGuOas5ODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115564; c=relaxed/simple;
	bh=Ot9dZ9VGfijBFpNN4l2sas7HxFqkXH4N4SfK0aRWMN8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b4t8Ytv3nYxcU3erkTvoIsISDHrVG1x5bw4NnYmhJ9XD/hdz6j/5JyGroexKEfOzDnBH11EPZw3u0f8MNDPBY++eIM0BKlX+sKqvSu2HgT3qcLRaiGrP3sghYalJz6TPwsw9HAG0R2QBsFXxzPrTgX0aDn+TbltGt8eSvY3N5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wgCz3yM1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wgCz3yM1"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71a122bf521so1085371b3a.2
        for <linux-modules@vger.kernel.org>; Mon, 23 Sep 2024 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727115562; x=1727720362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oaCRsbnNWrRaFere+ELhrZId4GCv9+17KXmOqdHXVow=;
        b=wgCz3yM1WZEEqRAoiYldouXucyJW7zym6bp1IiEf0byn0GDWa12Y3GBmgotS7h7jtX
         PsPSBMBAVTOKQyKy19vHq2mXsz/JkTPB76wkYz5byFWYPWEmpEneAQ5dV06bDgiw3P9Q
         eRKGOUGoPXCEyoAYfGyJdlVauKeaFkQsCBEPQXiF0m9NgBw5peBM/eTuOzX3Pk2ex1ur
         BuVMsksCT21EJmZjDKXtI/6rJO3WKSRRMfaB7IlIvRLR3Sx7XfWmHxVzIhPQkMNY/55N
         wa60m9tzz8rQny4tHJPCqibI/fmI2JGOMt5QGIzvvI/a7PBxWPzml2NOKMjtg20S8ec7
         IXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115562; x=1727720362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaCRsbnNWrRaFere+ELhrZId4GCv9+17KXmOqdHXVow=;
        b=d7KQWt4JLqdJCfiSVmc523VV19NmJKOsECs2NKVrKD3vm8OsaPV6SxV+VuPsL2+MIh
         8WNaDE3G7M9/YluCLratchkLxDQPKfiE8s0lYcNeZUjvdy8szHM73V76K3N5VqapWfkU
         b4f0kexh9pKQg7NYisYcxd+1gzdPaZf9nVaXirc7bHvO9G3Kx7hkZOCnqAhFCcEQuaIi
         svkuT5Hc6yEm6cuDfOzBFrMqOJHdMsBoTF2Wazl2h3bXglFckdT/2fhedOZ4dHkK7F9q
         ddcUlLXRUu4stR62I10WPENBxTqBboqwkcIAj/D6SL0l9pAf3Z3+ARM6Hk+8P6h87Ryq
         VOXg==
X-Forwarded-Encrypted: i=1; AJvYcCWCSf8FhB9KEikQFeGd52cAWpViSt9j1ed4SX0IzScFmNBovuUXv69e1A9LeTnlGrPEcUvVwqIuvYavrVEV@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9AZOBbzM6fg4mNTwqmuU8cbhDWXEDTVcIS3ThtQ5pou0Hapt
	D2Db4jsuXbu/9+7aEKD3E2lin1WbWxjRGyTx8XSY2xVo1+ZlD/6TCAhNMJ4bFokL272bvOa7ygu
	UYejx2hpeBYBFEN6AuaSdegGayg==
X-Google-Smtp-Source: AGHT+IGgYP6fjgneZDlNtYZaBPXV084hh6eLWrDiE/RaKFs2xYRWbrbifhbSENhjTwFTncb+Fjv3BWnlVd6hjI5gp8c=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6a00:6f5b:b0:70d:1285:bbcf with
 SMTP id d2e1a72fcca58-7199c6ed0f8mr16986b3a.0.1727115562282; Mon, 23 Sep 2024
 11:19:22 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:18:55 +0000
In-Reply-To: <20240923181846.549877-22-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240923181846.549877-22-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=samitolvanen@google.com;
 h=from:subject; bh=Ot9dZ9VGfijBFpNN4l2sas7HxFqkXH4N4SfK0aRWMN8=;
 b=owGbwMvMwCEWxa662nLh8irG02pJDGkfN3KZH3u4/t3F3Van9p6MPLvruFdScYyw8bOVUY+Nc
 8zP+ya7d5SyMIhxMMiKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJpLMwMqwqD84o0jhZrtu9
 RKqm3jYi/vwblu7Ds/hX3DQUOn/PfgUjQ0Orx6O0KUtk326tsF38Y4XT0YrEN4tPrzZgqtm2ybX iERMA
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240923181846.549877-31-samitolvanen@google.com>
Subject: [PATCH v3 09/20] gendwarfksyms: Expand array_type
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, Petr Pavlu <petr.pavlu@suse.com>, 
	Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, 
	Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
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
---
 scripts/gendwarfksyms/dwarf.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/gendwarfksyms/dwarf.c b/scripts/gendwarfksyms/dwarf.c
index 5bdab5b80ca2..caf25da0a9b9 100644
--- a/scripts/gendwarfksyms/dwarf.c
+++ b/scripts/gendwarfksyms/dwarf.c
@@ -217,6 +217,7 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(encoding)
 	}
 
 DEFINE_MATCH(formal_parameter)
+DEFINE_MATCH(subrange)
 
 bool match_all(Dwarf_Die *die)
 {
@@ -339,6 +340,33 @@ DEFINE_PROCESS_TYPE(shared)
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
@@ -434,7 +462,9 @@ static int process_type(struct state *state, struct die *parent, Dwarf_Die *die)
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
2.46.0.792.g87dc391469-goog

