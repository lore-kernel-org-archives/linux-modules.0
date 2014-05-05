Return-Path: <lucas.de.marchi@gmail.com>
Date: Mon, 5 May 2014 12:37:12 +0000
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
	Gustavo Sverzut Barbieri <barbieri@gmail.com>,
	linux-modules <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] Fix recursion loop in mod_count_all_dependencies()
Message-ID: <20140505123710.GB24741@politreco>
References: <53484327.5Nr2aWdyWz5+36kD%matwey.kornilov@gmail.com>
 <CAKi4VALtbKS=wj1KncN+kt+5hRPLDYxzkuDDg-3Cm+wr2mK5JQ@mail.gmail.com>
 <CANkykrBdJ-u-OWWgBZj_Jsghd8oqhC6AtRK7dvs=EGFt7EozMQ@mail.gmail.com>
 <CAJs94EZbVaS=N0xpAQbAySBzX_e6JR1o8FJkrJ0f4buCWvsZSA@mail.gmail.com>
 <20140502141357.GA24741@politreco>
 <87a9axc82r.fsf@rustcorp.com.au>
 <CAKi4VAL4+nErBqO+z-LJCYxuMqEHmsv0272ju6xQQ2W9ra3+wg@mail.gmail.com>
 <87ppjsbkmi.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ppjsbkmi.fsf@rustcorp.com.au>
List-ID: <linux-modules.vger.kernel.org>

On Mon, May 05, 2014 at 07:41:33PM +0930, Rusty Russell wrote:
> Lucas De Marchi <lucas.de.marchi@gmail.com> writes:
> > On Sun, May 4, 2014 at 10:45 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
> >> Note that in the case where two modules could satisfy a dependencies,
> >> it may not be a real loop?
> >
> > What do you mean here? How could that be the case for *depmod*?
> 
> Sorry, it's a theoretical case; no one does anything this crazy:
> 
>  A provides symbol S1.
>  B provides symbol S1, needs S2.
>  C needs S1, provides S2.
>  D provides S2.

This never worked. While calculating the dependencies one module will simply
override the previous module providing the symbol... and this will depend on
the path walking order.

However the kernel's modpost already warned about 2 modules providing the same
symbol:

	WARNING: /home/lucas/p/kmod/testsuite/module-playground/moduleC: 'printB' exported twice. Previous export was in /home/lucas/p/kmod/testsuite/module-playground/moduleB.ko

And if we try to load it anyway in the kernel, it fails as it should:

	[  618.643592] moduleC: exports duplicate symbol printB (owned by moduleB)


In the case of duplicate symbols, we could make depmod fail as well, just like if there are loops.

For my tests I used the diff below.

----8<---------------
diff --git a/testsuite/module-playground/moduleC.c b/testsuite/module-playground/moduleC.c
index b74cb07..bf5b5aa 100644
--- a/testsuite/module-playground/moduleC.c
+++ b/testsuite/module-playground/moduleC.c
@@ -8,17 +8,16 @@
 
 static int __init test_module_init(void)
 {
-	printC();
 	printB();
 	return 0;
 }
 module_init(test_module_init);
 
-void printC(void)
+void printB(void)
 {
-	pr_warn("Hello, world C\n");
+	pr_warn("Hello, world C, faking module B\n");
 }
-EXPORT_SYMBOL(printC);
+EXPORT_SYMBOL(printB);
 
 MODULE_AUTHOR("Lucas De Marchi <lucas.demarchi@intel.com>");
 MODULE_LICENSE("GPL");
---->8---------------


Lucas De Marchi
