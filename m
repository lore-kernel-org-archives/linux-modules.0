Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA586265CCD
	for <linux-modules@vger.kernel.org>; Sat,  8 Nov 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762576935; cv=none; b=Xukf9CILlNj4l2Ua+g9z6QNmQ1/EsJkZFyH28pBwVLcjx17IISat1IQFrowCD7VfvAShtdUgp0ypzBNHBwMbqYoflr/9tXt5K7l7UGAjIhSg8fv8lccLiTgorkYyYdVajg0WV0lI86aDbZGt0EjSpFLVJ6k6WwGQqnTltlzFaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762576935; c=relaxed/simple;
	bh=o3wOfF27ur4z3h/xReeEQrFXq2cfuiSwFtis1gOMNJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYm7AXngNBeHoDGRtmLYclpCRmIrRsr02Vtb3WQvGFrSt5hwUu6BgWJHH/P/UPCzgVQGLZ3Xfn76q9wewwZYbsYZiYFkzzfepkqsoZ3T+OxxAe6W2EQ6e/GVCUadmTCK9vvJM7frhwNiAOBf+JP/Ne1LkBR24XLSlizRKnfv/Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnkH17XT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnkH17XT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2959197b68eso60605ad.1
        for <linux-modules@vger.kernel.org>; Fri, 07 Nov 2025 20:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762576933; x=1763181733; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=azDN9d+mBYpQ3GzwIMlTNX5zY817O0f+omqPNR3WIz4=;
        b=TnkH17XTuXWDKxaPPZ5RDrmdx4by4lL12aqG8DZtjxYJhcCbInZsMDql2isdC0waC8
         LnKief2xLsATX4ewMXyE4eS1Q9+GdmDlCA9u/tJ4Kngz6OqLPeibT/LDWIuqjr43MLQH
         uqu1cp7aSWQ7dfOs46bVVCxceazu9ERmoicQuvDtbSEFQVA/cvjSU/joijOMIC4z1N+r
         oBkZmKIvt27AQyQKJnYxZ3j3i+bJ2N4nwLU8bDsfTF94AkfNz0bnG3+itNxYXW4wx+fJ
         VKIqHc2pPWFPJh5SGnUt5Q5mikEzTnnkcmMO1qK5FcF573fjXmUnRwvC8pbjG0HTOpZH
         /WkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762576933; x=1763181733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azDN9d+mBYpQ3GzwIMlTNX5zY817O0f+omqPNR3WIz4=;
        b=XHPCQ6Fu7QkUzafmAjAT2LW9SpXciEjffX4RJoCNM1vClvJaQjrf0ZkLw7GL+zGo+o
         Y7/r9tRTRSEwhLb2ElD9k9nMRCRq4KMIK30YShsdwLcZjuOPegOy45LgzSNr0lluTHzQ
         ZB1QXI1ZkZTH6SnrrEx615X9y5OAzZha73Hqku/TZm9W1LQNK+ylrWAus+8oAYlubwr8
         yGF1r/RNB6fohrtE/Xvz166OLvydWJtlB8Pa2nTswEQEF6n4MbXiv6waV1IJck08+GuE
         I3SuxjcxvfXjtbog6EQqYDvVfJHpBK/mMDS9IBPwrndFZ6Acg7/cukPqDELNeTxaMEHb
         8U7A==
X-Forwarded-Encrypted: i=1; AJvYcCXJpS//NLjiUrgcRoyECdeC09UTPhNtSco1HsPeURxakfqDSJFOdUexKf9ERK62LoQ7Yrjrve3nJDTeVDmO@vger.kernel.org
X-Gm-Message-State: AOJu0YzFg2HrLp9hg8zu5uWCp7vV5rObLTSv7/1iBtdxa70t+96lSrdA
	kOPhzZ/j6hPaLWJLYzfmdRUrRcV6DzM0B92uMChhOvb6twSVtdQst3iR+zdvkJhwCw==
X-Gm-Gg: ASbGncuw0B6dh2d5ozwTubkMjAdAd9HGbLe/godamCuKVp4gWUbVCnIrnjF2VlEIw2U
	2s7yMlhqVzU5Ob1DIpaiy0gHtwt0zzHhOTw7MrsYNmX/61KoJ8JMufgxq9R/RboHbCvl1StJtEt
	3O3/YeQvKB/Tcx2n7do3kaFBK5BN6oUoEvLFzr74YLGe0oR66gFSIL01mGdRUOf+yUXIab/uXLv
	LyKXO5spp4zUOrRc3M1RakyT9SSuL7WANu3IQNcCVIu1QBDlpL7STpZQ2W5fsusp5S2FzWY3Kqd
	prAsZfr+6IhMBYe9g25adqJBrDk0qxknJQsC6evi6u4ZrGO3Pj4cdrjkAlaR6uOEEjGoX6LNnTZ
	eUK3XWzmiJXPFG93HTNaqPQvTnEOpNm/5phMjhiMJ8N+oI6LPrLQh1RNEovK71lh/KpkIGoKwSI
	5/W9TsPtN6U+9olZQumVNNAROW96grfdHYQu8VYjitUQvV8p8krwTSsOprE94rS5hQG2Y=
X-Google-Smtp-Source: AGHT+IHXcJAO5bRmh3BWE773IMnp2AnRueynfhX6M2VVx4LYpR4UPWTsbM2ypOtSyIqT3Gyw2lO+AA==
X-Received: by 2002:a17:902:ec90:b0:294:f745:fe7b with SMTP id d9443c01a7336-297e5641a9emr927785ad.6.1762576932420;
        Fri, 07 Nov 2025 20:42:12 -0800 (PST)
Received: from google.com (204.167.125.34.bc.googleusercontent.com. [34.125.167.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccc19asm75661395ad.104.2025.11.07.20.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 20:42:11 -0800 (PST)
Date: Sat, 8 Nov 2025 04:42:06 +0000
From: Sami Tolvanen <samitolvanen@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Haiyue Wang <haiyuewa@163.com>, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, linux-modules@vger.kernel.org,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: Only rust/bindings.o build fail on rust-1.91.0
Message-ID: <20251108044206.GA3038215@google.com>
References: <b8c1c73d-bf8b-4bf2-beb1-84ffdcd60547@163.com>
 <CANiq72kX4Yep3pNVq8Ge=txQbPnMO=zKsci5cPgz5LDS=D6NoQ@mail.gmail.com>
 <CABCJKud0G+Xh+Wbtg4SDGvk4Yh5nmt5YgHEPj-H0y8GO5R3Amw@mail.gmail.com>
 <CANiq72mw66ADx7LoUuqY6h9KCU=uFzcNQXZ21kMP7jBjCyyaHQ@mail.gmail.com>
 <CANiq72=OFO8fBpJ6xvGunYrx5hXfcjQJ=YDqFxtMPWDzfzwpKw@mail.gmail.com>
 <CABCJKue1xeY7CGHScG04PdHT6TOPgsOpZVKWwgzO65qwAcbEJg@mail.gmail.com>
 <CANiq72ncHgjjJ_c2fdTgOO9LxmmotRS8S6pwyckLmPJG_4GPNg@mail.gmail.com>
 <CANiq72kcRsTWPhQVJ18P6RUxL=+c1Z8BJkyK_kRR8EBmmH+cWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kcRsTWPhQVJ18P6RUxL=+c1Z8BJkyK_kRR8EBmmH+cWg@mail.gmail.com>

On Sat, Nov 08, 2025 at 05:04:06AM +0100, Miguel Ojeda wrote:
> On Sat, Nov 8, 2025 at 4:51 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > What do you mean?
> 
> Do you mean in some cases? i.e. like with `CLIPPY=1`?

Ah, nevermind. I was looking at a stale object file. If there are no
exports, we should obviously skip gendwarfksyms.

For C objects, we use nm to check for __export_symbol_* symbols
before we attempt to generate symbol versions (see gen_symversions
in scripts/Makefile.build). We could do something similar for Rust
objects too, or just bail out early in gendwarfksyms if it's passed an
empty symbol list.

The trivial patch below should fix the issue.

Sami

---

From d1a4096cd328beae3323a1beb207c7cb5e770770 Mon Sep 17 00:00:00 2001
From: Sami Tolvanen <samitolvanen@google.com>
Date: Sat, 8 Nov 2025 04:26:10 +0000
Subject: [PATCH] gendwarfksyms: Skip files with no exports

Don't attempt to process files if we have no symbol versions to
calculate.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/gendwarfksyms/gendwarfksyms.c | 3 ++-
 scripts/gendwarfksyms/gendwarfksyms.h | 2 +-
 scripts/gendwarfksyms/symbols.c       | 4 +++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/gendwarfksyms/gendwarfksyms.c b/scripts/gendwarfksyms/gendwarfksyms.c
index 08ae61eb327e..f5203d1640ee 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.c
+++ b/scripts/gendwarfksyms/gendwarfksyms.c
@@ -138,7 +138,8 @@ int main(int argc, char **argv)
 		error("no input files?");
 	}
 
-	symbol_read_exports(stdin);
+	if (!symbol_read_exports(stdin))
+		return 0;
 
 	if (symtypes_file) {
 		symfile = fopen(symtypes_file, "w");
diff --git a/scripts/gendwarfksyms/gendwarfksyms.h b/scripts/gendwarfksyms/gendwarfksyms.h
index d9c06d2cb1df..32cec8f7695a 100644
--- a/scripts/gendwarfksyms/gendwarfksyms.h
+++ b/scripts/gendwarfksyms/gendwarfksyms.h
@@ -123,7 +123,7 @@ struct symbol {
 typedef void (*symbol_callback_t)(struct symbol *, void *arg);
 
 bool is_symbol_ptr(const char *name);
-void symbol_read_exports(FILE *file);
+int symbol_read_exports(FILE *file);
 void symbol_read_symtab(int fd);
 struct symbol *symbol_get(const char *name);
 void symbol_set_ptr(struct symbol *sym, Dwarf_Die *ptr);
diff --git a/scripts/gendwarfksyms/symbols.c b/scripts/gendwarfksyms/symbols.c
index 35ed594f0749..ecddcb5ffcdf 100644
--- a/scripts/gendwarfksyms/symbols.c
+++ b/scripts/gendwarfksyms/symbols.c
@@ -128,7 +128,7 @@ static bool is_exported(const char *name)
 	return for_each(name, NULL, NULL) > 0;
 }
 
-void symbol_read_exports(FILE *file)
+int symbol_read_exports(FILE *file)
 {
 	struct symbol *sym;
 	char *line = NULL;
@@ -159,6 +159,8 @@ void symbol_read_exports(FILE *file)
 
 	free(line);
 	debug("%d exported symbols", nsym);
+
+	return nsym;
 }
 
 static void get_symbol(struct symbol *sym, void *arg)
-- 
2.51.2.1041.gc1ab5b90ca-goog

