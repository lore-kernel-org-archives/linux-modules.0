Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DF42F9C37;
	Tue, 31 Mar 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990746; cv=none; b=fJDP7/BlQGqMcFg6MNaPFoY88+Vsk574tMIX2eZNHfQF1Tt1cB2MRKQrNmdVaOYdaaLVEIa2gJbmQaOZDJSrJqigzBDpMWwVMMBz/FtVdSKr9+oM+Tm7typ/NFg71U0zgsKkuTDCW6wHidwzrX/KAgEKUXog1DT9v2SnKhTik18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990746; c=relaxed/simple;
	bh=/p6fYFwc9ex+wd+URurcNtkQn9Tmr3NBkrUthGd9bb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s/Q5FXGvunudxuiNUjGBdihrSDLWyc4Pky/o76wKk02C1WBUnqP6IjBn23CQOVPaEl8ZW0H1utDs5UewbcpkTypqA4xnIl7EAmlEisuq5ShACBbTW9LyCtGVNtkEwxxt99aRqPEtZOsaDd2ySP1ez5kzbItMFDZK5JKPr6ZTAIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax4eb0fS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax4eb0fS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7790C19423;
	Tue, 31 Mar 2026 20:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774990746;
	bh=/p6fYFwc9ex+wd+URurcNtkQn9Tmr3NBkrUthGd9bb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ax4eb0fSRXbUmBXGu0/MvozWP55I8SSYplPc4WhZeG624NwxaHGDlYAiiqZ0HQR2N
	 NG1fPat63UcZQ2SlNsn+PulNKSwFHTTdOdSAlstwtV0zru0xhrJfR8xlS5LD+H+PrV
	 IdIgfSQtYk1ZE4SO55VepbB0MYjcOCjHg0afVqrVojlD7jNuEMtqzPrndDvP6/cpyb
	 /NW9BI8xCaz6kZ/Calc4ZuwjWiHs90A9vfR+dAfc5dePxoSahX35fpMNT9/S9Vc+Er
	 +JPO73iNa+9nZzegR2iCE8Q9E9XGuyW6gIN9gdCLpDRdRrJwQuPmhnFsmDPyPFRxz9
	 dFezIi1RQR9Hw==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 2/2] rust: macros: simplify `format!` arguments
Date: Tue, 31 Mar 2026 22:58:49 +0200
Message-ID: <20260331205849.498295-2-ojeda@kernel.org>
In-Reply-To: <20260331205849.498295-1-ojeda@kernel.org>
References: <20260331205849.498295-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clippy in Rust 1.88.0 (only) reported [1] up to the previous commit:

    warning: variables can be used directly in the `format!` string
       --> rust/macros/module.rs:112:23
        |
    112 |         let content = format!("{param}:{content}", param = param, content = content);
        |                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        |
        = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#uninlined_format_args
        = note: `-W clippy::uninlined-format-args` implied by `-W clippy::all`
        = help: to override `-W clippy::all` add `#[allow(clippy::uninlined_format_args)]`
    help: change this to
        |
    112 -         let content = format!("{param}:{content}", param = param, content = content);
    112 +         let content = format!("{param}:{content}");

The reason it only triggers in that version is that the lint was moved
from `pedantic` to `style` in Rust 1.88.0 and then back to `pedantic`
in Rust 1.89.0 [2][3].

In this case, the suggestion is fair and a pure simplification, thus
just apply it.

In addition, do the same for another place in the file that Clippy does
not report because it is multi-line.

Link: https://lore.kernel.org/rust-for-linux/CANiq72=drAtf3y_DZ-2o4jb6Az9J3Yj4QYwWnbRui4sm4AJD3Q@mail.gmail.com/ [1]
Link: https://github.com/rust-lang/rust-clippy/pull/15287 [2]
Link: https://github.com/rust-lang/rust-clippy/issues/15151 [3]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 rust/macros/module.rs | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index e16298e520c7..06c18e207508 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -52,12 +52,7 @@ fn new(module: &'a str) -> Self {
     fn emit_base(&mut self, field: &str, content: &str, builtin: bool, param: bool) {
         let string = if builtin {
             // Built-in modules prefix their modinfo strings by `module.`.
-            format!(
-                "{module}.{field}={content}\0",
-                module = self.module,
-                field = field,
-                content = content
-            )
+            format!("{module}.{field}={content}\0", module = self.module)
         } else {
             // Loadable modules' modinfo strings go as-is.
             format!("{field}={content}\0")
@@ -109,7 +104,7 @@ fn emit_internal(&mut self, field: &str, content: &str, param: bool) {
     }
 
     fn emit_param(&mut self, field: &str, param: &str, content: &str) {
-        let content = format!("{param}:{content}", param = param, content = content);
+        let content = format!("{param}:{content}");
         self.emit_internal(field, &content, true);
     }
 
-- 
2.53.0

