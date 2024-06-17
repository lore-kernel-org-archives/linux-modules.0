Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AD1991CD
	for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 17:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647124; cv=none; b=cY2pMfKKSllI+9P1tu/eC9H6Ba+t6s7tgVV2G3QERm9g4POTVyT3u9Rrnd3HuFqhJLVnPsPHkG5WkBnmoJBMo4ZYrTKrN5vsYtEYYYVTr4/O8qBQciS4/ckEUMRBrllon/3dbbI9xfZTcpfLnB1EvQ1KkNa+rFD5/SCFNUU83/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647124; c=relaxed/simple;
	bh=rJM9lNpfTY2lBoAmMOvcqcpNNy6swQ5ugktfxvNPVeE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cVBv+E/Bpsf+vy9H+5/7juUSX0L9NJZIJyG7+Jw7APYlu5wCS2H0WMCRaPbaWV1NOZ1FPVExM8PYJEvQIhalJfaWzpWiWtM1pT6ENItoLvPks8za5cCGEn5gc1arZEJktW4VM5+SJ1LVnQr2hD8KXo+IcMFqHd2bBfcLiNie0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnSWJJpH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnSWJJpH"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfb0e59ac7cso9231884276.0
        for <linux-modules@vger.kernel.org>; Mon, 17 Jun 2024 10:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718647122; x=1719251922; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Al6oYvjeu808n2Qb7f95tGIv0BU5o2UXOdmPU+OQTkI=;
        b=wnSWJJpHMlDE2N8jK695FyeYxArBhyVJY71ZGU3vrw6N/bWGXrmTyHwo0wiB8kcplR
         7jykoAeRYLsmt4IrpfPHfaCA5lTdzfHll5OVEcqWTGOI3i2Ws5wK7bDjyAaS2/y7ietj
         E0cCEjRaXbjpTfoymeNKu1mkUR8rJhszfcjDe8RIReyHShqWn+uVwUv5Vzb4CplwQgVt
         Ww7iJ5JXTo6+qa/3u2e+mfR2I+rrdCX5hknIbMWWwlfQxK35r0EzRcWtCG/7zfdFGhXP
         /JoOc0nzYibK99adlF8A6BWDG6OY8jVl2cEIGk/M4BFibIhIHrEf57noy/k2/AxSsE2i
         K4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718647122; x=1719251922;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Al6oYvjeu808n2Qb7f95tGIv0BU5o2UXOdmPU+OQTkI=;
        b=BbeCGlH3Vp8tSvtfIO31d5rY+ApaDXhJd5hwDFvMKwDRQNjfE1/N7+0ZScioXclyX5
         iAkQZHF10n3Rw16wEFHP35Z9KFdyU5GjIa05HBO+N2wut1bNAgf0tj0t6z3tJo0lgtmz
         5slJnxmk6VuARKhHjwYeApB9R+RRzdwLcuKo2TpXOu0XTENXVqOZgypozoYVoI8AAdNG
         I8iiaFo5TA4o4PaHSegZlrsxL6OGM/jSxjyTUCRhdRuWaIr4OuHDBrnh7Tu2RX+i60Th
         PsSh1GfH4HzIT1U+t9f2hDPAIVXqsxCrLbrZsca/3dXjJy18hkbGD4GthDE7YiYBFjRz
         C8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfHnUxkEOE3tV2UxfnXMlu9mrV2juX5xkpjGC+0G7VWHA9R1kwMCTobYRkkpSDsCCbO8pZ/xx5EXuf0oEi8qNuQ1Y+yMjpfQa2ef5AXw==
X-Gm-Message-State: AOJu0YyHFf+qOfqT0XCt0QHjf0VlBFks+Ao5JEDrExrNlemGuPkrzHkx
	fEAHUBgLD89A06J7afYPNT55plNArtKxRnP384JbiVZqu8s37lzPshc/XgSSFwHbXjOTQ+G4f8O
	Eg1LFe+EKdcO11uOJDG/vdsgJVQ==
X-Google-Smtp-Source: AGHT+IGLprv7GhBP6neE3HiuXn2ed+MEUclZy5dU5KGTDqzgVm1AGourYHGVIQ+Ek143H5gX2bqohmq85Q7pvEp2Vbw=
X-Received: from samitolvanen.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:4f92])
 (user=samitolvanen job=sendgmr) by 2002:a05:6902:18d4:b0:dff:3a41:3670 with
 SMTP id 3f1490d57ef6-dff3a4142bdmr2026210276.10.1718647121802; Mon, 17 Jun
 2024 10:58:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:58:28 +0000
In-Reply-To: <20240617175818.58219-17-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240617175818.58219-17-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2203; i=samitolvanen@google.com;
 h=from:subject; bh=rJM9lNpfTY2lBoAmMOvcqcpNNy6swQ5ugktfxvNPVeE=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBmcHk7A54POYQP2SP+j8e2QM627dstf2daWWvdD
 RRz32R5XK2JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCZnB5OwAKCRBMtfaEi7xW
 7lX6C/9WLHYYGkgA9zTOWpSQYm35c0WbQxcNuSPcsWbNoQtwL814zB9FAEdhTnukWGgPCm6IskJ
 Se3ziWceeRMGeNGK7EGPhv3sLKZlwJ2/22ydxO+HGcgGTaWY7vqQWRYQSPE790hm71Abu0ncCFP
 owLv44ow5xhj1G5a6OWMHG+CElCCptz9zEVZJ+onSaO6VUM4UzSUgY8KxnFWXLifWmut/9b6FYB
 G+Yq64pQM8eI5hfvDztBhKlbY2JWSCL+05/LKfckaQEEMvY9sInhZJpa8c+MEQ36AZTV9Ju7tZZ
 Kzx5VY8NBFORTz5FaMXWEq1/X00G7gGNS7e5zMIop/cDbCN2P/8RlEV6PENYw5donWYsujdGJ6z
 8QQRJuA/Qc3h2rRVzz41sXx35BEGuw0Y5vvHIxMzHMv2SW5O6EtAk/3u8qftF4xtoIK/8Ll2T0s e3hQ9ePdCwjFvR3yxc33wCaDde5ynfAEJJT5bSQlm1clkaxv0ZLMwVbEn9xBTo9MsaWtY=
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240617175818.58219-26-samitolvanen@google.com>
Subject: [PATCH 09/15] gendwarfksyms: Expand array_type
From: Sami Tolvanen <samitolvanen@google.com>
To: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Add support for expanding DW_TAG_array_type, and the subrange type
indicating array size.

Example output with --debug:

  variable array_type [34] {
    pointer_type <unnamed> {
      const_type <unnamed> {
        base_type char byte_size(1)
      }
    }
  };

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 tools/gendwarfksyms/types.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/gendwarfksyms/types.c b/tools/gendwarfksyms/types.c
index a56aeaa4f3a1..b1b82d166eb8 100644
--- a/tools/gendwarfksyms/types.c
+++ b/tools/gendwarfksyms/types.c
@@ -177,6 +177,7 @@ DEFINE_PROCESS_UDATA_ATTRIBUTE(byte_size)
 	}
 
 DEFINE_MATCH(formal_parameter)
+DEFINE_MATCH(subrange)
 
 bool match_all(Dwarf_Die *die)
 {
@@ -268,6 +269,31 @@ DEFINE_PROCESS_TYPE(shared)
 DEFINE_PROCESS_TYPE(volatile)
 DEFINE_PROCESS_TYPE(typedef)
 
+static int process_subrange_type(struct state *state, struct cached_die *cache,
+				 Dwarf_Die *die)
+{
+	Dwarf_Word count = 0;
+
+	if (get_udata_attr(die, DW_AT_count, &count))
+		return check(process_fmt(state, cache, "[%" PRIu64 "]", count));
+
+	return check(process(state, cache, "[]"));
+}
+
+static int process_array_type(struct state *state, struct cached_die *cache,
+			      Dwarf_Die *die)
+{
+	check(process(state, cache, "array_type "));
+	/* Array size */
+	check(process_die_container(state, cache, die, process_type,
+				    match_subrange_type));
+	check(process(state, cache, " {"));
+	check(process_linebreak(cache, 1));
+	check(process_type_attr(state, cache, die));
+	check(process_linebreak(cache, -1));
+	return check(process(state, cache, "}"));
+}
+
 static int __process_subroutine_type(struct state *state,
 				     struct cached_die *cache, Dwarf_Die *die,
 				     const char *type)
@@ -378,7 +404,9 @@ static int process_type(struct state *state, struct cached_die *parent,
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
2.45.2.627.g7a2c4fd464-goog

