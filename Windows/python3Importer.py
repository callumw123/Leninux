
def install_and_import(package, packageName):
    import importlib
    try:
        importlib.import_module(packageName)
    except ImportError:
        import subprocess
        subprocess.check_call(
            ["py", '-3', '-m', 'pip', 'install', package])  # install pkg
        subprocess.check_call(
            ["py", '-3', '-m', 'pip', 'install', "--upgrade", package])  # upgrade pkg
    finally:
        importlib.invalidate_caches()
        globals()[package] = importlib.import_module(packageName)
