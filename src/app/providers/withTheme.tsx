import { ThemeProvider, createTheme } from '@mui/material';
import { StyledEngineProvider } from '@mui/material/styles';

const rootElement = document.getElementById("root")!;

const theme = createTheme({
  components: {
    MuiPopover: {
      defaultProps: {
        container: rootElement,
      },
    },
    MuiPopper: {
      defaultProps: {
        container: rootElement,
      },
    },
    MuiDialog: {
      defaultProps: {
        container: rootElement,
      },
    },
    MuiModal: {
      defaultProps: {
        container: rootElement,
      },
    },
  },
});

export const withTheme = (component: () => React.ReactNode) => () => (
  <StyledEngineProvider injectFirst>
    <ThemeProvider theme={theme}>
      {component()}
    </ThemeProvider>
  </StyledEngineProvider>
);
